<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ProductRequestUpgradeByAdmin extends Mailable
{
    use Queueable, SerializesModels;

    public $name;
    public $lastname;
    public $prodName;
    public $messageContent;
    public $imageLogo;
    /**
     * Create a new message instance.
     */
    public function __construct($name, $lastname, $prodName, $messageContent, $imageLogo)
    {
        //
        $this->name             = $name;
        $this->lastname         = $lastname;
        $this->prodName         = $prodName;
        $this->messageContent   = $messageContent;
        $this->imageLogo        = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Solicitud de mejora de producto',
            tags: ['solicitud', 'mejor', 'producto', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.productRequestUpgradeByAdmin',
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
        
        // return [
        //     Attachment::fromPath($this->imagePath),
        // ];
    }
    /**
     * Build the message.
     */
    public function build()
    {
        return
            $this->view('emails.productRequestUpgradeByAdmin')
                ->with([
                    'name'              => $this->name,
                    'lastname'          => $this->lastname,
                    'prodName'          => $this->prodName,
                    'messageContent'    => $this->messageContent,
                    'imageLogo'         => $this->imageLogo,
                ]);
    }
}
