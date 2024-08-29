<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class UserVerificationCodeMail extends Mailable
{
    use Queueable, SerializesModels;
    
    public $name;
    public $lastname;
    public $code;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $code, $imageLogo)
    {
        $this->name         = $name;
        $this->lastname     = $lastname;
        $this->code         = $code;
        $this->imageLogo    = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            // from: new Address('cointrade@example.com', 'Jeffrey Way'),
            subject: 'Verifica tu correo electrónico para CoinTrade',
            tags: ['código', 'verificación'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.userVerificationCode',
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
            $this->view('emails.userVerificationCode')
                ->with([
                    'name'      => $this->name,
                    'lastname'  => $this->lastname,
                    'code'      => $this->code,
                    'imageLogo' => $this->imageLogo,
                ]);
    }
}
