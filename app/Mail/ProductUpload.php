<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ProductUpload extends Mailable
{
    use Queueable, SerializesModels;

    public $user;
    public $product;
    public $prodCost;
    public $prodComission;
    public $prodTotal;
    public $imageFront;
    public $imageBack;
    public $imageCertification;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($user, $product, $prodCost, $prodComission, $prodTotal, $imageFront, $imageBack, $imageCertification, $imageLogo)
    {
        $this->user                 = $user;
        $this->product              = $product;
        $this->prodCost             = $prodCost;
        $this->prodComission        = $prodComission;
        $this->prodTotal            = $prodTotal;
        $this->imageFront           = $imageFront;
        $this->imageBack            = $imageBack;
        $this->imageCertification   = $imageCertification;
        $this->imageLogo            = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Producto guardado',
            tags: ['producto', 'guardado', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.productUpload',
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
            $this->view('emails.productUpload')
                ->with([
                    'product'               => $this->product,
                    'user'                  => $this->user,
                    'prodCost'              => $this->prodCost,
                    'prodComission'         => $this->prodComission,
                    'prodTotal'             => $this->prodTotal,
                    'imageFront'            => $this->imageFront,
                    'imageBack'             => $this->imageBack,
                    'imageCertification'    => $this->imageCertification,
                    'imageLogo'             => $this->imageLogo,
                ]);
    }
}
