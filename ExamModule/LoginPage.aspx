<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="ExamModuleASP.Forms.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Created CSS File For Login Page -->
    <link rel="stylesheet" type="text/css" href="../StyleSheets/Login.css">
    <!-- Available CSS and JavaScript File(s) Used For Show Password Functionality  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">  
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
</head>
<body>
    <!-- Available Script Used For Show Password Functionality When Hovered Over Button Type -->
    <script type="text/javascript">  
        $(document).ready(function () {  
            $('#show_password').hover(function show() {   
                $('#txt_pass').attr('type', 'text');  
                $('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');  
            },  
            function () {  
                $('#txt_pass').attr('type', 'password');  
                $('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');  
            });
            $('#ShowPassword').click(function () {  
                $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');  
            });  
        });  
    </script>  
    <form id="form1" runat="server">
        <!-- Division With topbar CSS Class for Display/Design Purpose -->
        <div class="topbar" >
            <asp:Label ID="lbl_LogIn" runat="server" Text="Student Portal" CssClass="labels"></asp:Label>
        </div>
        <!-- Division Contains The Main Body Of The Page -->
        <div style="padding:16px">
            <!-- Label And TextBox For Email -->
            <asp:Label ID="lbl_email" runat="server" Text="Email ID:" Font-Bold="True" Font-Size="Large"></asp:Label><br />
            <asp:TextBox ID="txt_email" runat="server"></asp:TextBox><br />
            <!-- Validator For The Expression And Requirement Of Valid Email-ID   -->
            <asp:RegularExpressionValidator ID="rev_email" runat="server" ErrorMessage="Please Enter Valid Email" ForeColor="Red" ControlToValidate="txt_email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator><br />
            <asp:RequiredFieldValidator ID="rfv_email" runat="server" ErrorMessage="Email Required" ControlToValidate="txt_email" ForeColor="Red"></asp:RequiredFieldValidator><br /><br />
            <!-- Label And TextBox For Password -->
            <asp:Label ID="lbl_pass" runat="server" Text="Password:" Font-Bold="True" Font-Size="Large"></asp:Label><br />
            <asp:TextBox ID="txt_pass" runat="server" TextMode="Password" ></asp:TextBox>
            <!-- Button To Display Password When Hovered Over -->
            <div style="text-align:right"><button id="show_password" class="buttons" type="button" >  <span class="fa fa-eye-slash icon"></span></button></div>
            <!-- Validator For The Requirement Of Password  -->
            <asp:RequiredFieldValidator ID="rfv_pass" runat="server" ErrorMessage="Password Required" ControlToValidate="txt_pass" ForeColor="Red"></asp:RequiredFieldValidator><br /><br />
            <!-- CheckBox And Label For Enabling The Remember Me Functionality For The Current User  -->
            <asp:CheckBox ID ="chk_rem" runat="server" style="margin-right:5px;"/>
            <asp:Label ID="lbl_rem" Font-Bold="true" runat="server" Text="Remember Me"></asp:Label><br /><br />
            <!-- Button To Perform LogIn Task  -->
            <div style="text-align:center"><asp:Button ID="btn_log" runat="server" Text="Log In" class="buttons" OnClick="btn_log_Click"/></div>
        </div>
        <!-- Division With bottombar CSS Class for Display/Design Purpose -->
        <div class="bottombar">
            <!-- ScriptManager And Update Panel Which Holds Label That Displays Current Time And Timer Which Updates It -->
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lbl_time" runat="server" Text="" CssClass="labels"></asp:Label>
                    <asp:Timer ID="tmr_time" runat="server" Interval="1000"></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
