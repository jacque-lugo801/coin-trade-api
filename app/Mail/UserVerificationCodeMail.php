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
    public $mailData;
    public $code;
    public $name;
    public $lastName;

    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $code)
    {
        // $this->mailData = $mailData;
        // $this->code = $code;
        $this->name = $name;
        $this->lastName = $lastname;
        $this->code = $code;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            from: new Address('cointrade@sending.com', 'Coin Trade'),
            subject: 'Verification Code',
            tags: ['verification', 'code'],
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
}
