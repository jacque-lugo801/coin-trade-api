<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class UserRegisterAccountMailByAdmin extends Mailable
{
    use Queueable, SerializesModels;
    // public $mailData;
    // public $code;
    public $name;
    public $lastname;
    public $rol;
    public $rolEnc;
    public $mailEnc;
    // public $rol;


    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $rol, $rolEnc, $mailEnc)
    {
        $this->name = $name;
        $this->lastName = $lastname;
        $this->rol = $rol;
        $this->rolEnc = $rolEnc;
        $this->mailEnc = $mailEnc;
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
            view: 'emails.userRegisterAccountByAdmin',
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
}
