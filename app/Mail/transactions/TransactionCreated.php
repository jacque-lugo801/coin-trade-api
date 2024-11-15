<?php

namespace App\Mail\transactions;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class TransactionCreated extends Mailable
{
    use Queueable, SerializesModels;
    public $user;
    public $transaction;
    public $imageLogo;

    /**
     * Create a new message instance.
     */
    public function __construct($user, $transaction, $imageLogo)
    {
        $this->user         = $user;
        $this->transaction  = $transaction;
        $this->imageLogo    = $imageLogo;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Su pedido ha sido completado ',
            tags: ['pedido', 'transacción', 'completado', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.transactions.transactionCreated',
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
            $this->view('emails.transactions.transactionCreated')
                ->with([
                    'user'          => $this->user,
                    'transaction'   => $this->transaction,
                    'imageLogo'     => $this->imageLogo,
                ]);
    }
}
