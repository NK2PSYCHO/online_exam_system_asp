<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MCQTest.aspx.cs" Inherits="ExamModuleASP.Forms.MCQTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Created CSS File For Test Pages -->
    <link rel="stylesheet" type="text/css" href="../StyleSheets/Test.css">
</head>
<body>
    <form id="form1" runat="server">
    <!-- ScriptManager Decalred Here As Multiple Update Panel Are Used Throughout -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <!-- Division With topbar CSS Class for Display/Design Purpose And Contains CountDown Timer -->
        <div class="topbar" >
            <asp:Label ID="lbl_test" runat="server" Text="MCQ Test" CssClass="labels"></asp:Label>
            <!-- Countdown Timer In Update Panel As Updated Every Second -->
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>   
                    <asp:Label ID="lbl_countdown" runat="server" Text="" style="float:right" CssClass="labels"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <!-- Division With split and left CSS Class for Display/Design Purpose And Contains Question -->
        <div class="split left" style="padding-left:30px">
            <div class="centered">
                <div>
                    <asp:Label ID="lbl_que" runat="server" Text="" class="label"></asp:Label>
                </div>
            </div>
        </div>
        <!-- Division With split and right CSS Class for Display/Design Purpose And RadioButtonList To Display And Select Options, Buttons For Next Previous And Submit -->
        <div class="split right">
            <div>
                <asp:RadioButtonList ID="rbl_Options" runat="server">
                </asp:RadioButtonList>
            </div>
            <asp:Button ID="btn_next" runat="server" Text="  Next  " class="buttonnext" OnClick="btn_next_Click" />
            <asp:Button ID="btn_prev" runat="server" Text="  Prev  " class="buttonprev" OnClick="btn_prev_Click"/>
            <!-- Submit Button In Update Panel As It Is To Be Called When Countdown Timer Runs Out -->
            <asp:UpdatePanel ID="UpdatePanel3" runat="server" EnableViewState="true">
                <ContentTemplate>
                    <asp:Button ID="btn_sub" runat="server" Text="Submit" CssClass="buttonnext" OnClick="btn_sub_Click"/>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <!-- Division With bottombar CSS Class for Display/Design Purpose -->
        <div class="bottombar">
            <!-- Update Panel Which Holds Label That Displays Current Time And Timer Which Updates It -->
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lbl_time" runat="server" Text="" CssClass="labels" ></asp:Label>
                    <asp:Timer ID="tmr_time" runat="server" Interval="1000" ></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
