<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckResult.aspx.cs" Inherits="ExamModuleASP.ExamModule.CheckResult" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../StyleSheets/Test.css">
    <style>
        .ext{
        width: 50%;
        padding: 12px 20px;
        margin: 8px 0;
        display: inline-block;
        border: 1px solid #ccc;
        box-sizing: border-box;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="topbar">
            <asp:Label ID="lbl_stat" runat="server" Text="Result"  CssClass="labels"></asp:Label>
        </div>
        <div class="split left" style="padding-left:10px">
            <asp:Label ID="lbl_Body" runat="server" Text=""></asp:Label><br /><br />
            <asp:DropDownList ID="ddl_options" runat="server" CssClass="ext" AutoPostBack="True" OnSelectedIndexChanged="ddl_options_SelectedIndexChanged" AppendDataBoundItems="True">
                <asp:ListItem Value="0" Text="[ Select ]" Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lbl_marks" runat="server" Text="" CssClass="buttonprev"></asp:Label>
            <asp:Button ID="btn_back" runat="server" Text="Go Back"  CssClass="buttonnext" OnClick="btn_back_Click"/>
        </div>
        <div class="split right">
            <asp:GridView ID="gdv_result" runat="server"></asp:GridView>
        </div>
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
