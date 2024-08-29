<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class UserConfigureAccount extends Mailable
{
    use Queueable, SerializesModels;
    
    public $name;
    public $lastname;
    public $website;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $website, $imageLogo)
    {
        $this->name     = $name;
        $this->lastname = $lastname;
        $this->website  = $website;
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
            view: 'emails.userConfigureAccount',
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
            $this->view('emails.userConfigureAccount')
                ->with([
                    'name'      => $this->name,
                    'lastname'  => $this->lastname,
                    'website'   => $this->website,
                    'imageLogo' => $this->imageLogo,
                ]);
    }
}
