<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class UserRegisterAccountMail extends Mailable
{
    use Queueable, SerializesModels;
    public $mailData;
    public $code;
    public $name;
    public $lastName;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $imageLogo)
    {
        $this->name         = $name;
        $this->lastName     = $lastname;
        $this->imageLogo    = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Hola ¡Te damos la bienvenida a CoinTrade!',
            tags: ['bienvenida', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.userRegisterAccount',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
    /**
     * Build the message.
     */
    public function build()
    {
        return
            $this->view('emails.userRegisterAccount')
                ->with([
                    'name'      => $this->name,
                    'lastName'  => $this->lastName,
                    'imageLogo' => $this->imageLogo,
                ]);
    }
}
