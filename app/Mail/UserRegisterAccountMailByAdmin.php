<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class UserRegisterAccountMailByAdmin extends Mailable
{
    use Queueable, SerializesModels;
    // public $mailData;
    // public $code;
    public $name;
    public $lastname;
    public $account;
    public $rol;
    // public $rolEnc;
    // public $mailEnc;
    public $website;
    // public $rol;
    public $imageLogo;


    /**
     * Create a new message instance.
     */
    // public function __construct($name, $lastname, $rol, $rolEnc, $mailEnc, $website)
    public function __construct($name, $lastname, $rol, $account, $website, $imageLogo)
    {
        $this->name         = $name;
        $this->lastname     = $lastname;
        $this->account      = $account;
        $this->rol          = $rol;
        // $this->rolEnc = $rolEnc;
        // $this->mailEnc = $mailEnc;
        $this->website      = $website;
        $this->imageLogo    = $imageLogo;
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
            view: 'emails.userRegisterAccountByAdmin',
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
            $this->view('emails.userRegisterAccountByAdmin')
                ->with([
                    'name'      => $this->name,
                    'lastname'  => $this->lastname,
                    'account'   => $this->account,
                    'rol'       => $this->rol,
                    'website'   => $this->website,
                    'imageLogo' => $this->imageLogo,
                ]);
    }
}
