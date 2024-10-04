<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link  href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <noscript>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">

      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    </noscript>
    <title>CoinTrade - Registro de cuenta</title>

    <style type="text/css">
      body { font-family: "Poppins", sans-serif; font-style: normal;}
      .tthin { font-weight: 100; }
      .textrathin { font-weight: 200; }
      .tlight { font-weight: 300; }
      .tregular { font-weight: 400; }
      .tmedium { font-weight: 500; }
      .tsemibold { font-weight: 600; }
      .tbold { font-weight: 700; }
      .textrabold { font-weight: 800; }
      .tblack { font-weight: 900; }
      .fnt_italic { font-style: italic; }
      .talign_center { text-align: center; }
      .talign_left { text-align: left; }
      .talign_right { text-align: right; }
      .talign_justify { text-align: justify; }
      .obj_fit_cover { object-fit: cover; object-position: center; }

      .dtable_cell { display: table-cell; }

      .valign_bottom { vertical-align: bottom; }
      .valign_middle { vertical-align: middle; }
      .valign_top { vertical-align: top; }
      .prelative { position: relative; }
      .pabsolute { position: absolute; }


      .txt_purple { color: #4d75db; }
      .txt_gray { color: #7d7d7d; }
      .txt_purple2 { color: #584ce2; }
      .txt_red { color: #eb2a29; }
      .txt_blue { color: #00356f; }

      .bdr_rad_15 { border-radius: 15px; }

      p { margin-top: 0 !important; }

      /* .bx_shadow { box-shadow: 8px 8px 15px 0px rgba(125,125,125, 0.75); } */
      /* .bx_shadow { box-shadow: 15px 15px 10px 0px rgba(125,125,125, 0.5); } */
      /* .bx_shadow { box-shadow: 12.5px 12.5px 15px -2.5px rgba(125,125,125, 0.5); }

      .bg_w_gradient { background: rgb(0,212,254); background: linear-gradient(90deg, rgba(0,212,254,1) 0%, rgba(28,168,245,1) 43%, rgba(56,125,237,1) 75%, rgba(87,76,227,1) 100%); } */

      @media only screen and (max-device-width: 660px), only screen and (max-width: 660px) {
        .mobile_shell, .td, .mobile_shell_pd,
        .table_fluid_mobile { width: 100% !important; min-width: 450px !important; }
      }
      @media only screen and (max-device-width: 520px), only screen and (max-width: 520px) {
        /* class="section1" style="padding: 0 40px;" */
        .section1 { padding: 0px 30px !important; }
        .section2 { padding: 0px 20px !important; }
        .section3 { padding: 0px 10px !important; }
        .section4 { padding: 0px 40px !important; }
        .section5 { padding: 0px 50px !important; }
        .section6 { padding: 0px 60px !important; }

        .image_logo1 img { width: 200px !important; }

        
        .image1 img { width: 175px !important; }


        .icon_floating1 { height: 102.5px !important; width: auto !important; }

        .td_button1, .td_button1 a{ width: 365px !important; }

      }
      @media only screen and (max-device-width: 480px), only screen and (max-width: 480px) {
        .fnt_9pt { font-size: 7pt !important; }
        .fnt_10pt { font-size: 8pt !important; }
        .fnt_11pt { font-size: 9pt !important; }
        .fnt_12pt { font-size: 10pt !important; }
        .fnt_13pt { font-size: 11pt !important; }
        .fnt_14pt { font-size: 12pt !important; }
        .fnt_15pt { font-size: 13pt !important; }
        .fnt_16pt { font-size: 14pt !important; }
        .fnt_17pt { font-size: 15pt !important; }
        .fnt_18pt { font-size: 16pt !important; }
        .fnt_19pt { font-size: 17pt !important; }
        .fnt_20pt { font-size: 18pt !important; }
        .fnt_21pt { font-size: 19pt !important; }
        .fnt_22pt { font-size: 20pt !important; }
        .fnt_23pt { font-size: 21pt !important; }
        .fnt_24pt { font-size: 22pt !important; }
        .fnt_25pt { font-size: 23pt !important; }
        .fnt_26pt { font-size: 24pt !important; }
        .fnt_27pt { font-size: 25pt !important; }
        .fnt_28pt { font-size: 26pt !important; }
        .fnt_29pt { font-size: 27pt !important; }
        .fnt_30pt { font-size: 28pt !important; }
        .fnt_31pt { font-size: 29pt !important; }
        .fnt_32pt { font-size: 30pt !important; }
        .fnt_33pt { font-size: 31pt !important; }
        .fnt_34pt { font-size: 32pt !important; }
        .fnt_35pt { font-size: 33pt !important; }
        .fnt_36pt { font-size: 34pt !important; }
        .fnt_37pt { font-size: 35pt !important; }
        .fnt_38pt { font-size: 36pt !important; }
        .fnt_39pt { font-size: 37pt !important; }
        .fnt_40pt { font-size: 38pt !important; }



        .section1 { padding: 0px 20px !important; }
        .section2 { padding: 0px 10px !important; }
        /* .section3 { padding: 0px 5px !important; } */
        .section3 { padding: 0px 0px !important; }
        .section4 { padding: 0px 30px !important; }
        .section5 { padding: 0px 40px !important; }
        .section6 { padding: 0px 50px !important; }

        .image_logo1 img { width: 305px !important; }
        
        .image1 img { width: 175px !important; }

        .icon_floating1 { height: 92.5px !important; width: auto !important; }

        .td_button1, .td_button1 a{ width: 340px !important; }
      }
    </style>
  </head>
  <body style="font-family: 'Poppins', sans-serif; font-weight: 400; font-size: 12pt; line-height: 1.2; padding: 0; margin: 0; display: block; width: 100%; background-color: #ffffff; color: #7d7d7d;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tbody>
        <tr>
          <td align="center" valign="top">
            <!-- Tabla principal -->
            <table width="660" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" class="mobile_shell" style="background-image: url('./images/BG.png'); background-position: center bottom; background-size: 100% 42.5%; background-repeat: no-repeat;">
              <tbody>
                <tr>
                  <td class="td" style="width: 660px; min-width: 660px; padding-bottom: 10px; ">
                    <!-- Tabla principal -->
                    <table width="660" border="0" cellspacing="0" cellpadding="0" class="mobile_shell_pd">
                      <tbody>
                        <tr>
                          <td class="section0" style="padding: 0;">
                            <!-- Space -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="">
                              <tbody>
                                <tr>
                                  <td height="22.5" style="font-size: 0; line-height: 0">
                                    &nbsp;
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Image Logo -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ecf1fa" style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
                              <tbody>
                                <tr>
                                  <td align="center" valign="top" class="section1" style="padding: 0 40px;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tbody>
                                        <tr>
                                          <td height="20" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td class="talign_center image_logo1" style="font-size: 0; line-height: 0" >
                                            <!-- <img src="http://localhost:4200/assets/icons/logos/[Project Files] Logo_CoinTrade.png" width="250" alt=""/> -->
                                            <!-- <img src="{{ route('image.show', ['imageName' => '[Project Files] Logo_CoinTrade.png']) }}" width="250" alt=""/> -->
                                            <!-- <img src="{{$message->embed('images/[Project Files] Logo_CoinTrade.png')}}" width="250" alt=""/> -->
                                            <!-- <img src="{{ asset('storage/images/' .$imageLogo) }}" width="250" alt=""/> -->
                                            
                                            <img src="{{$message->embed($imageLogo)}}" width="250" alt=""/>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="20" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Separator -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ecf1fa" style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
                              <tbody>
                                <tr>
                                  <td align="center" valign="top" class="section3" style="padding: 0 20px;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tbody>
                                        <tr>
                                          <td class="talign_center" style="font-size: 0; line-height: 0" >
                                            <hr style="border: 0.5px solid #ffffff;">
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Title -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ecf1fa" style="">
                              <tbody>
                                <tr>
                                  <td align="center" valign="top" class="section1" style="padding: 0 40px;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tbody>
                                        <tr>
                                          <td height="15" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_center tbold fnt_20pt" style="color: #C78A37; font-size: 20pt; line-height: 1.75;">
                                            Información de su producto
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="15" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Space -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#f5f5f5">
                              <tbody>
                                <tr>
                                  <td height="25" style="font-size: 0; line-height: 0">
                                    &nbsp;
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Content -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#f5f5f5" style="border-bottom-left-radius: 15px; border-bottom-right-radius: 15px;">
                              <tbody>
                                <tr>
                                  <td align="center" valign="middle" class="section1" style="padding: 0 40px;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tbody>
                                        <tr>
                                          <td height="25" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_left tmedium fnt_15pt prelative" style="color: #1B243E; font-size: 15pt; line-height: 1.2;">
                                            Hola, {{$user->usu_name}}.
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="25" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_left tmedium fnt_15pt" style="color: #1B243E; font-size: 15pt; line-height: 1.2;">
                                            Has agregado el siguiente producto
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="25" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td style="border: 1px solid #eaebff; padding: 15px 10px;">
                                            <table  width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tbody>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            ID:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{$product->prod_sku}}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Nombre:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{$product->prod_name}}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Descripción:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {!! $product->prod_description !!}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Tipo:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{$product->productType->ptpe_name}}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            País:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{$product->productCountry->coun_name}} ({{$product->productCountry->coun_iso_alpha2}})
                                                        </td>
                                                    </tr>
                                                    <!-- <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Categoria:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{ ucfirst($product->productGroup->pgrp_name) }}
                                                        </td>
                                                    </tr>
                                                @if(strtolower($product->productType->ptpe_name) == strtolower('Moneda'))
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Subcategoria:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{ ucfirst($product->productCategory->pcat_name) }}
                                                        </td>
                                                    </tr>
                                                @endif -->
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Stock:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{ $product->prod_stock }}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Costo:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            $ {{$prodCost}} MXN
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Comision:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            $ {{$prodComission}} MXN
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="15" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Total:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            $ {{$prodTotal}} MXN
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="25" style="font-size: 0; line-height: 0">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1"  valign="top" class="talign_left tbold fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            Estado:
                                                        </td>
                                                        <td class="space_col_product" width="15"></td>
                                                        <td colspan="2"  valign="top" class="talign_left tmedium fnt_11pt" style="color: #1B243E; font-size: 11pt; line-height: 1.2; padding-bottom: 5px;">
                                                            {{ ucfirst($product->productStatus->psts_name) }}
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="10" style="font-size: 0; line-height: 0">
                                                &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_right tmedium fnt_10pt" style="color: #1B243E; font-size: 10pt; line-height: 1.2;">
                                            *Para ver la información completa de su producto, visite el la sección <span class="tbold">Productos</span> del Panel General de su cuenta.
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="25" style="font-size: 0; line-height: 0">
                                                &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_left tmedium fnt_15pt" style="color: #1B243E; font-size: 15pt; line-height: 1.2;">
                                            Este será revisado y se le enviará una notificación en caso de que ocurra algunade las siguientes situaciones:
                                                
                                                <table  width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td height="15" style="font-size: 0; line-height: 0">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="middle" class="talign_left tmedium fnt_15pt" style="color: #1B243E; font-size: 15pt; line-height: 1.2;">
                                                                1) El producto es aprobado y será mostrado en la lista de productos del sitio.
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="middle" class="talign_left tmedium fnt_15pt" style="color: #1B243E; font-size: 15pt; line-height: 1.2;">
                                                                2) El producto necesita una mejora en cualquiera de sus caracteristicas.
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="50" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_left tmedium fnt_13pt" style="color: #1B243E; font-size: 13pt; line-height: 1.2;">
                                            En caso de no recibir el correo, pongase en contacto con el administrador del sitio.
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="50" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Space -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="">
                              <tbody>
                                <tr>
                                  <td height="30" style="font-size: 0; line-height: 0">
                                    &nbsp;
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                            <!-- Reminder -->
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="">
                              <tbody>
                                <tr>
                                  <td align="center" valign="middle" class="section1" style="padding: 0 40px;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tbody>
                                        <tr>
                                          <td height="15" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                        <tr>
                                          <td valign="middle" class="talign_left tmedium fnt_9pt" style="color: #6d6d6d; font-size: 9pt; line-height: 1.2;">
                                            Este correo electrónico ha sido enviado desde una dirección que no puede recibir correos electrónicos. No respondas este correo electrónico.
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="30" style="font-size: 0; line-height: 0">
                                            &nbsp;
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
  </body>
</html>