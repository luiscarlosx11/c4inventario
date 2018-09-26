<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="errores.aspx.cs" Inherits="elecion.errores" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui" />
    <title>Error 404 - PAE</title>
    <link rel="apple-touch-icon" href="/app-assets/images/ico/apple-icon-120.png" />
    <link rel="shortcut icon" type="image/x-icon" href="/app-assets/images/ico/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet" />
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="/app-assets/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/feather/style.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/flag-icon-css/css/flag-icon.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/pace.css" />
    <!-- END VENDOR CSS-->
    <!-- BEGIN STACK CSS-->
    <link rel="stylesheet" type="text/css" href="/app-assets/css/bootstrap-extended.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/app.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/colors.css" />
    <!-- END STACK CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/menu/menu-types/vertical-menu.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/menu/menu-types/vertical-overlay-menu.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/pages/error.css" />
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
</head>
<body data-open="click" data-menu="vertical-menu" data-col="1-column" class="vertical-layout vertical-menu 1-column  blank-page blank-page">
    <div class="app-content content container-fluid">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body center centrarCelda">
                <section class="flexbox-container">
                    <div class="col-md-4 offset-md-4 col-xs-10 offset-xs-1">
                        <div class="card-header bg-transparent no-border pb-0">
                            <h2 class="error-code text-xs-center mb-2">
                                <asp:Label runat="server" ID="numError"></asp:Label></h2>
                            <h3 class="text-uppercase text-xs-center">
                                <asp:Label runat="server" ID="msjerror"></asp:Label></h3><br />
                            <a href="/" class="btn btn-primary btn-block font-small-3"><i class="ft-home"></i>Volver a Inicio</a>
                        </div>
                        <div class="card-body collapse in centrarCelda">
                            <div class="row py-2 centrarCelda">
                                <div class="col-xs-12 col-sm-6 col-md-6 centrarCelda">
                                    
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent pb-0">
                            <div class="row">
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </div>
    </div>
</body>
</html>