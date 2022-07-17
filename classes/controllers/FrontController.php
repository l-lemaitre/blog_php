<?php
    namespace App\Classes\Controllers;

    use App\Classes\Models\PostRepository;
    use App\Classes\Models\UserRepository;
    use Symfony\Component\Mailer\Transport;
    use Symfony\Component\Mailer\Mailer;
    use Symfony\Component\Mime\Email;

    class FrontController extends Controller {
        public function displayHomePage() {
            if(isset($_GET["reply"])) {
                $reply = htmlspecialchars($_GET["reply"]);

                $this->render('views/templates/front',
                    'index.html.twig',
                    ['reply' => $reply]
                );
            } else {
                $this->render('views/templates/front',
                    'index.html.twig');
            }
        }

        public function renderContactForm() {
            // If the "message" POST variable is declared and different from NULL
            if(isset($_POST["message"])) {
                $firstname = htmlspecialchars(trim($_POST["firstname"])); // We get the firstname
                $lastname = htmlspecialchars(trim($_POST["lastname"])); // We get the lastname
                $email = htmlspecialchars(strtolower(trim($_POST["email"]))); // We retrieve the email
                $subject = strip_tags(trim($_POST["subject"])); // We retrieve the subject of the message
                $content = strip_tags(trim($_POST["content"])); // We retrieve the content of the message
                $valid = true;
                $errors = [];

                // Check first and last name
                if(empty($firstname) || empty($lastname)) {
                    $valid = false;
                    $errors['emptyName'] = "Le \"Prénom\" et/ou le \"Nom\" ne peuvent être vide.";
                }

                // Check that the first and last name are in the correct format
                elseif(!preg_match("/^[A-Za-zàäâçéèëêïîöôùüû\s_-]{2,}$/", $firstname) || !preg_match("/^[A-Za-zàäâçéèëêïîöôùüû\s_-]{2,}$/", $lastname)) {
                    $valid = false;
                    $errors['invalidName'] = "Le \"Prénom\" et/ou le \"Nom\" doivent contenir au moins 2 caractères et ne pas comporter de caractères spéciaux.";
                }

                // Verification of the e-mail address
                if(empty($email)) {
                    $valid = false;
                    $errors['emptyMail'] = "L'adresse \"E-mail\" ne peut être vide.";
                }

                // Check that the email address is in the correct format
                elseif(!preg_match("/^[0-9a-z\-_.]+@[0-9a-z]+\.[a-z]{2,3}$/i", $email)) {
                    $valid = false;
                    $errors['invalidMail'] = "L'adresse \"E-mail\" n'est pas valide.";
                }

                // Check message subject
                if(empty($subject)) {
                    $valid = false;
                    $errors['emptySubject'] = "Le \"Sujet\" du message ne peut être vide.";
                }

                // Check message content
                if(empty($content)) {
                    $valid = false;
                    $errors['emptyContent'] = "Le champ de saisie \"Votre message\" ne peut être vide.";
                }

                // If all the conditions are met then we move on to processing
                if($valid) {
                    // We set the default time offset of all date/time functions to that of French time
                    date_default_timezone_set("Europe/Paris");

                    // Add the message in HTML format
                    $message = "<!DOCTYPE html><html lang=\"fr\"><body>
                        <h2 style=\"color: #6610f2;\">Message envoyé depuis le formulaire de contact du blog <a href=\"http://127.0.0.1/blog_php\" style=\"color: #6610f2; text-decoration:none;\">llemaitre.com</a></h2>"
                                    . nl2br("<p><b>Prénom : </b>" . $firstname . "
                           <b>Nom : </b>" . $lastname . "
                           <b>E-mail : </b>" . $email . "
                           <b>Date : </b>" . date("d-m-Y H:i:s") . "
                           <b>Sujet : </b>" . $subject . "
                           <b>Message : </b>" . $content . "</p>
                           </body></html>");

                    $transport = Transport::fromDsn('smtp://user:pass@smtp.example.com:port');
                    $mailer = new Mailer($transport);

                    $email = (new Email())
                        ->from($email)
                        ->to('contact@llemaitre.com')
                        //->cc('cc@example.com')
                        //->bcc('bcc@example.com')
                        //->replyTo('fabien@example.com')
                        //->priority(Email::PRIORITY_HIGH)
                        ->subject($subject)
                        //->text('Sending emails is fun again!')
                        ->html($message);

                    $return = $mailer->send($email);

                    if(!$return) {
                        header("location:index?reply=ok");
                    }

                    else{
                        header("location:index?reply=error");
                    }
                }

                $this->render('views/templates/front',
                    'index.html.twig',
                    ['firstname' => $firstname,
                    'lastname' => $lastname,
                    'email' => $email,
                    'subject' => $subject,
                    'content' => $content,
                    'errors' => $errors]
                );
            }
        }

        public function displayPosts($page = null) {
            $posts = PostRepository::getPostsPusblished();

            $this->render('views/templates/front',
                'posts.html.twig',
                ['posts' => $posts]
            );
        }

        public function displayPost($slug, $id) {
            $post = PostRepository::getPostById($id);

            $this->render('views/templates/front',
                'post.html.twig',
                ['post' => $post]
            );
        }
    }
