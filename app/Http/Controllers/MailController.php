<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

use Mail;
use App\Mail\DemoMail;

class MailController extends Controller
{
    //
    public function index() {
        $mailData = [
            'title' => 'Mail from Coin Trade',
            'body' => 'This is for testing app'
        ];

        Mail::to('jacque.lugo801@gmail.com')->send(new DemoMail($mailData));

        dd('Email send successfully.');
    }
}
