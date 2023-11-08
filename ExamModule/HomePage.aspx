<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="ExamModuleASP.Forms.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Created CSS File For Home Page -->
    <link rel="stylesheet" type="text/css" href="../StyleSheets/HomePage.css">
</head>
<body>
    <form id="form1" runat="server">
        <!-- Division With topbar CSS Class for Display/Design Purpose And Contains DropDownList For Other Available Pages Accessible -->
        <div class="topbar" >
            <asp:Label ID="lbl_home" runat="server" Text="Home" CssClass="barlabels"></asp:Label>
            <!-- DropDownList Type To Display The Links For Other Available Pages Accessible -->
            <div class="dropdown">
                <button class="dropbtn">More▼
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="PasswordChange.aspx">Change Password</a>
                    <a href="CheckResult.aspx">Check Result</a>
                    <a href="LoginPage.aspx">Log Out</a>
                </div>
            </div>
        </div>
        <!-- Division With split and left CSS Class for Display/Design Purpose And Contains Information About Student -->
        <div class="split left">
            <asp:Label ID="lbl_det" runat="server" Text="Student Details:" Font-Bold="True" Font-Size="X-Large" CssClass="displabel" ></asp:Label><br />
            <!-- Labels To Display Student Name -->
            <br /><asp:Label ID="lbl_pren" runat="server" Text="Name:" Font-Size="Large" CssClass="displabel"></asp:Label><br />
            <asp:Label ID="lbl_name" runat="server" Font-Size="Large" CssClass="displabel"></asp:Label><br /><br />
            <!-- Labels To Display Student Email-Id -->
            <br /><asp:Label ID="lbl_pree" runat="server" Text="Email:"  Font-Size="Large" CssClass="displabel"></asp:Label><br />
            <asp:Label ID="lbl_email" runat="server" Font-Size="Large" CssClass="displabel"></asp:Label><br /><br />
            <!-- Labels To Display Student Class -->
            <br /><asp:Label ID="lbl_prec" runat="server" Text="Class:"  Font-Size="Large" CssClass="displabel"></asp:Label><br />
            <asp:Label ID="lbl_class" runat="server" Font-Size="Large" CssClass="displabel"></asp:Label><br /><br />
            <!-- Labels To Display Student Enrollment Number -->
            <br /><asp:Label ID="lbl_preen" runat="server" Text="Enrollment Number:" class="label" Font-Size="Large" CssClass="displabel"></asp:Label><br />
            <asp:Label ID="lbl_enroll" runat="server" Font-Size="Large" CssClass="displabel"></asp:Label><br /><br />
            <!-- Labels To Display Student Exam Seat Number -->
            <br /><asp:Label ID="lbl_preS" runat="server" Text="Seat Number:" class="label" Font-Size="Large" CssClass="displabel"></asp:Label><br />
            <asp:Label ID="lbl_seat" runat="server" Font-Size="Large" CssClass="displabel"></asp:Label><br /><br />
        </div>
        <!-- Division With split and right CSS Class for Display/Design Purpose And Contains Information About Current User(Student)'s Exam Schedule -->
        <div class="split right">
            <!-- Labels To Display Current User(Student)'s Exam Schedule -->
            <asp:Label ID="lbl_schdet" runat="server" Text="Schedule Status:" Font-Size="X-Large" Font-Bold="true" ></asp:Label>
            <div>
                <br /><asp:Label ID="lbl_detail" runat="server" Text="" ></asp:Label>
            </div>
            <!-- Button Which Will Appear Only If The User(Student) Is In Time Of The Scheduled Exam -->
            <asp:Button ID="btn_start" runat="server" Text="Start" CssClass="buttons" OnClick="btn_start_Click" />
        </div>
        <!-- Division With bottombar CSS Class for Display/Design Purpose -->
        <div class="bottombar">
            <!-- ScriptManager And Update Panel Which Holds Label That Displays Current Time And Timer Which Updates It -->
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lbl_time" runat="server" Text="" CssClass="barlabels"></asp:Label>
                    <asp:Timer ID="tmr_time" runat="server" Interval="1000"></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
