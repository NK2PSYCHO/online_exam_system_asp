<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PasswordChange.aspx.cs" Inherits="ExamModuleASP.ExamModule.PasswordChange" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Created CSS File For LogIn Page As This Page Uses Almost Same Controls -->
    <link rel="stylesheet" type="text/css" href="../StyleSheets/Login.css">
</head>
<body>
    <form id="form1" runat="server">
        <!-- Division With topbar CSS Class for Display/Design Purpose -->
        <div class="topbar">
            <asp:Label ID="lbl_wel" runat="server" Text="Changing Password" CssClass="labels"></asp:Label>
        </div>
        <div style="margin-left:30px;margin-top:20px">
            <!-- Label And TextBox For Current Password -->
            <asp:Label ID="lbl_oldp" runat="server" Text="Enter Current Password:"></asp:Label><br />
            <asp:TextBox ID="txt_oldp" runat="server" style="width:98%" TextMode="Password"></asp:TextBox><br /><br />
            <!-- Label And TextBox For New Password -->
            <asp:Label ID="lbl_newp" runat="server" Text="Enter New Password:"></asp:Label><br />
            <asp:TextBox ID="txt_newp" runat="server" style="width:98%"  TextMode="Password" ViewStateMode="Enabled"></asp:TextBox><br /><br />
            <!-- Label And TextBox To Confirm New Password -->
            <asp:Label ID="lbl_newpc" runat="server" Text="Confirm New Password:"></asp:Label><br />
            <asp:TextBox ID="txt_newpc" runat="server" style="width:98%"  TextMode="Password"></asp:TextBox>
            <!-- Validator For The Comparision Of New Password(s)  -->
            <asp:CompareValidator ID="CV_pass" runat="server" ErrorMessage="Passwords Does Not Match" ForeColor="Red" ControlToCompare="txt_newp" ControlToValidate="txt_newpc"></asp:CompareValidator><br />
            <!-- Button For Change Password Task -->
            <asp:Button ID="btn_change" runat="server" Text="Change Password" class="buttons" OnClick="btn_change_Click"/>
            <!-- Button Which Helps To Go Back To HomePage -->
            <asp:Button ID="btn_back" runat="server" Text="Go Back" style="margin-left:90px"  class="buttons" OnClick="btn_back_Click" />
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
