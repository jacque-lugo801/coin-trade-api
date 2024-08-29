<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Mail\Mailables\Attachment;
use Illuminate\Queue\SerializesModels;

class ProductApproveByAdmin extends Mailable
{
    use Queueable, SerializesModels;

    public $name;
    public $lastname;
    public $prodName;
    // public $imageF;
    // public $imageB;
    public $isApprove;
    public $prodTotal;
    public $imageLogo;
    /**
     * Create a new message instance.
     */
    // public function __construct($name, $lastname, $prodName, $imageF, $imageB, $isApprove, $imageLogo)
    public function __construct($name, $lastname, $prodName, $prodTotal, $isApprove, $imageLogo)
    {
        //
        $this->name         = $name;
        $this->lastname     = $lastname;
        $this->prodName     = $prodName;
        // $this->imageF   = $imageF;
        // $this->imageB   = $imageB;
        $this->prodTotal    = $prodTotal;
        $this->isApprove    = $isApprove;
        $this->imageLogo    = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Información sobre su producto',
            tags: ['informacion', 'producto', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.productApproveByAdmin',
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
            $this->view('emails.productApproveByAdmin')
                ->with([
                    'name'      => $this->name,
                    'lastname'  => $this->lastname,
                    'prodName'  => $this->prodName,
                    // 'imageF' => $this->imageF,
                    // 'imageB' => $this->imageB,
                    'prodTotal' => $this->prodTotal,
                    'isApprove' => $this->isApprove,
                    'imageLogo' => $this->imageLogo,
                ]);
    }
}
