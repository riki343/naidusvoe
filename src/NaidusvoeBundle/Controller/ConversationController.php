<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\Attachment;
use NaidusvoeBundle\Entity\Conversation;
use NaidusvoeBundle\Entity\Favorites;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\Message;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class ConversationController extends Controller {
    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/message/send/{adv_id}-{user_id}", name="message-send", options={"expose"=true})
     * @param Request $request
     * @param int $user_id
     * @param int $adv_id
     * @return JsonResponse
     */
    public function sendMessageAction(Request $request, $user_id, $adv_id) {
        $data = json_decode($request->getContent(), true);
        $message = $data['message'];
        /** @var User $user */
        $user = $this->getUser();
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $conversation = Conversation::getConversation($em, $user->getId(), $user_id, $adv_id);
        if (count($conversation) == 0) {
            $conversation = Conversation::addConversation($em, $user->getId(), $user_id, $adv_id);
        } else {
            $conversation = $conversation[0];
        }
        try {
            $message = Message::addNewMessage($em, $conversation->getId(), $user->getId(), $message);
            Conversation::updateConversation($em, $conversation->getId());
        } catch (\Exception $ex) {
            $from = 'class: Message, function: addNewMessage';
            $this->get('error_logger')->registerException($ex, $from);
            return new JsonResponse(false);
        }
        return new JsonResponse($message->getInArray());
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @return JsonResponse
     */
    public function getConversationsAction() {
        /** @var User $user */
        $user = $this->getUser();
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $conversations = Conversation::getConversationsByUser($em, $user->getId());
        return new JsonResponse(Functions::arrayToJsonSingle($conversations));
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @param int $conv_id
     * @return JsonResponse
     */
    public function getConversationAction($conv_id) {
        /** @var User $user */
        $user = $this->getUser();
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $conversation = $em->find('NaidusvoeBundle:Conversation', $conv_id);
        if ($conversation->getUser1ID() == $user->getId() || $conversation->getUser2ID() == $user->getId()) {
            $jsonConv = $conversation->getInArray();
            Conversation::setViewed($em, $conversation->getMessages());
            return new JsonResponse($jsonConv);
        } else {
            return new JsonResponse(false);
        }
    }
}