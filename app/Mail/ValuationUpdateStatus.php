<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ValuationUpdateStatus extends Mailable
{
    use Queueable, SerializesModels;
    public $user;
    public $product;
    public $valuation;
    public $valuationTotal;
    public $imageFront;
    public $imageBack;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($user, $product, $valuation, $valuationTotal, $imageFront, $imageBack, $imageLogo)
    {
        $this->user             = $user;
        $this->product          = $product;
        $this->valuation        = $valuation;
        $this->valuationTotal   = $valuationTotal;
        $this->imageFront       = $imageFront;
        $this->imageBack        = $imageBack;
        $this->imageLogo        = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Cambio de estado de valuación',
            tags: ['cambio', 'estado', 'valuacion', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.valuations.valuationUpdateStatusNotification',
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
            $this->view('emails.valuations.valuationUpdateStatusNotification')
                ->with([
                    'user'              => $this->user,
                    'product'           => $this->product,
                    'valuation'         => $this->valuation,
                    'valuationTotal'    => $this->valuationTotal,
                    'imageFront'        => $this->imageFront,
                    'imageBack'         => $this->imageBack,
                    'imageLogo'         => $this->imageLogo,
                ]);
    }
}
