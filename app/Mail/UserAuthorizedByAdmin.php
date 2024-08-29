<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class UserAuthorizedByAdmin extends Mailable
{
    use Queueable, SerializesModels;
    public $name;
    public $lastname;
    public $statusAccount;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $statusAccount, $imageLogo)
    {
        //
        $this->name             = $name;
        $this->lastname         = $lastname;
        $this->statusAccount    = $statusAccount;
        $this->imageLogo        = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Su cuenta ha sido modificada',
            tags: ['modificación', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.userAuthorizedByAdmin',
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
            $this->view('emails.userAuthorizedByAdmin')
                ->with([
                    'name'          => $this->name,
                    'lastname'      => $this->lastname,
                    'statusAccount' => $this->statusAccount,
                    'imageLogo'     => $this->imageLogo,
                ]);
    }
}
