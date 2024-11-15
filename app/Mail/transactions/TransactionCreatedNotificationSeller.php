<?php

namespace App\Mail\transactions;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class TransactionCreatedNotificationSeller extends Mailable
{
    use Queueable, SerializesModels;
    // public $user;
    public $transaction;
    public $imageLogo;
    public $detail;

    /**
     * Create a new message instance.
     */
    public function __construct($transaction, $detail, $imageLogo)
    {
        // $this->user         = $user;
        $this->transaction  = $transaction;
        $this->imageLogo    = $imageLogo;
        $this->detail   = $detail;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            // subject: 'Su producto ha sido vendido',
            // subject: 'Uno o varios de tus productos ha sido elegido',
            subject: 'Uno de tus productos ha sido elegido',
            tags: ['producto', 'transacción', 'vendido', 'cointrade'],
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.transactions.transactionCreatedNotificationSeller',
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
            $this->view('emails.transactions.transactionCreatedNotificationSeller')
                ->with([
                    // 'user'          => $this->user,
                    'transaction'   => $this->transaction,
                    'imageLogo'     => $this->imageLogo,
                    'detail'        => $this->detail,
                ]);
    }
}
