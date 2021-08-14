<%--
  Created by IntelliJ IDEA.
  User: 40747
  Date: 2021/8/9
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>用户信息的增删改查</title>
    <link rel="stylesheet" type="text/css" href="${basePath}jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${basePath}jquery-easyui-1.3.3/themes/icon.css">

    <script type="text/javascript" src="${basePath}jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${basePath}jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${basePath}jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${basePath}js/validate.js"></script>
    <script type="text/javascript" src="${basePath}js/Convert_Pinyin.js"></script>

    <%
        String path = request.getContextPath();
        String basePath = "";
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
        pageContext.setAttribute("basePath", basePath);
    %>
</head>
<body class="easyui-layout">
<table id="dg" title="用户列表" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true" url="${basePath}findUsers"
       fit="true" toolbar="#tb" remoteSort="false" multiSort="true">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="column2" width="50" align="center" sortable="true">姓名</th>
        <th field="column3" width="100" align="center" sortable="true">姓名全拼</th>
        <th field="column4" width="100" align="center" sortable="true">性别</th>
        <th field="column5" width="100" align="center" sortable="true">身份证证件类型</th>
        <th field="column6" width="100" align="center" sortable="true">身份证件号码</th>
        <th field="column7" width="100" align="center" sortable="true" formatter="formatBirthday">出生日期</th>
        <th field="column8" width="100" align="center" sortable="true">手机号码</th>
        <th field="column9" width="100" align="center" sortable="true">电子邮箱</th>
<%--        <th field="createtime" width="100" align="center" sortable="true" formatter="formatDate">创建时间</th>
        <th field="updatetime" width="100" align="center" sortable="true" formatter="formatDate">更新时间</th>--%>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openUserAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit"
           plain="true">修改</a>
        <a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
    </div>

    <div>
        &nbsp;姓名：&nbsp;<input type="text" id="s_name" size="15" onkeydown="if(event.keyCode==13) searchUser()"/>
        &nbsp;性别：&nbsp;<select class="easyui-combobox" id="s_gender" editable="false" style="width: 100px;">
        <option value="">请选择性别...</option>
        <option value="男">男</option>
        <option value="女">女</option>
    </select>
        &nbsp;手机号码：&nbsp;<input type="text" id="s_phoneNumber" size="15" onkeydown="if(event.keyCode==13) searchUser()"/>
        &nbsp;电子邮件：&nbsp;<input type="text" id="s_email" size="15" onkeydown="if(event.keyCode==13) searchUser()"/>
        <a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
        <a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-reset" plain="true">清空</a>
    </div>

</div>

<div id="dlg" class="easyui-dialog" style="width: 1000px; height: 300px; padding: 10px 20px" closed="true"
     buttons="#dlg-buttons">
    <form id="fm" method="POST" enctype="application/x-www-form-unlencoded">
        <table cellspacing="8px">
            <tr>
                <td>姓名：</td>
                <td><input type="text" id="column2" name="column2"
                           class="easyui-validatebox easyui-textbox" validType="" required="true"/></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>姓名全拼：</td>
                <td><input type="text" id="column3" name="column3"
                           class="easyui-validatebox easyui-textbox" validType="english" required="true"/></td>
            </tr>
            <tr>
                <td>身份证证件类型：</td>
                <td><select class="easyui-combobox" id="column5" name="column5" editable="false" style="width: 175px;">
                    <option value="">请选择身份证证件类型...</option>
                    <option value="居民身份证">居民身份证</option>
                    <option value="士官证">士官证</option>
                    <option value="学生证">学生证</option>
                    <option value="驾驶证">驾驶证</option>
                    <option value="护照">护照</option>
                    <option value="港澳通行证">港澳通行证</option>
                </select></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>身份证件号码：</td>
                <td><input type="text" id="column6" name="column6" class="easyui-validatebox"
                           validType="" required="true"/></td>
            </tr>
            <tr>
                <td>性别：</td>
                <td><input type="radio" id="man" name="column4" value="男">男</input>
                    <input type="radio" id="women" name="column4" value="女">女</input>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>出身日期：</td>
                <td><input type="text" id="column7" name="column7" class="easyui-datebox"
                               validType="date" required="true"/></td>
            </tr>
            <tr>
                <td>手机号码：</td>
                <td><input type="text" id="column8" name="column8" class="easyui-validatebox easyui-textbox"
                           validType="mobile" required="true"/>&nbsp;</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>电子邮箱：</td>
                <td><input type="text" id="column9" name="column9" class="easyui-validatebox easyui-textbox"
                           validType="email" required="true"/></td>
            </tr>
        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
<script type="text/javascript">

    /**
     * 时间格式显式
     * @param val
     * @param row
     * @returns
     */
    function formatBirthday(val, row) {
        if (val==null)
            return '';
        //var format = 'yyyy-MM-dd';
        var d = new Date(val.time);
        var month = d.getMonth()+1;
        var day = d.getDate();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return d.getFullYear()+'-'+month+'-'+day;
    }
    function formatDate(val, row) {
        if (val==null)
            return '';
        var format = 'yyyy-MM-dd hh:mm:ss';
        var d = new Date(val.time);
        var month = d.getMonth()+1;
        var day = d.getDate();
        var hour = d.getHours();
        var minute = d.getMinutes();
        var second = d.getSeconds();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        if (hour < 10) {
            hour = "0" + hour;
        }
        if (minute < 10) {
            minute = "0" + minute;
        }
        if (second < 10) {
            second = "0" + second;
        }
        return d.getFullYear()+'-'+month+'-'+d.getDate()+
            ' '+hour+':'+minute+':'+second;
    }

    var url;

    function searchUser() {
        $("#dg").datagrid('load', {
            "column2": $("#s_name").val(),
            "column4": $("#s_gender").combobox("getValue"),
            "column8": $("#s_phoneNumber").val(),
            "column9": $("#s_email").val(),
        });
    }

    function resetSearch() {
        $("#s_name").val("");
        $("#s_gender").combobox("setValue", "");
        $("#s_phoneNumber").val("");
        $("#s_email").val("");
    }

    function deleteUser() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的数据！");
            return;
        }
        var strIds = [];
        for (var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].column1);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确认要删除这<font color=red>"
            + selectedRows.length + "</font>条数据吗？", function (r) {
            if (r) {
                $.post("${basePath}userDelete", {
                    ids: ids
                }, function (result) {
                    if (result.errres) {
                        $.messager.alert("系统提示", result.errmsg);
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", "数据删除失败！");
                    }
                }, "json");
            }
        });
    }

    function openUserAddDialog() {

        resetValue();
        autoInput();

        $("#dlg").dialog("open").dialog("setTitle", "添加用户");
        url = "${basePath}userSave";
    }

    function openUserModifyDialog() {

        resetValue();
        autoInput();

        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length != 1) {
            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
            return;
        }
        var row = selectedRows[0];
        //var jsonRow = JSON.stringify(row);
        //alert(jsonRow);
        var year = 1900+row.column7.year;
        var month = 1+row.column7.month;
        var day = row.column7.date;
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        var birthday1 = year+"-"+month+"-"+day;
        //alert(birthday);
        //row.column7 = birthday;
        //alert(row.column7);
        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
        //$('#fm').form('load', row);
        $("#column2").val(row.column2);
        $("#column3").val(row.column3);
        //不知道为什么，若combobox的赋值放在datebox赋值或者prop赋值之后，datebox和prop虽然有值，但显示不了
        $("#column5").combobox("setValue", row.column5);
        if(row.column4 == "男") {
            $("#man").prop('checked', true);
        } else {
            $("#women").prop('checked', true);
        }
        $("#column6").val(row.column6);
        $("#column7").datebox("setValue",birthday1);
        $("#column8").val(row.column8);
        $("#column9").val(row.column9);
        url = "${basePath}userSave?column1=" + row.column1;
    }

    function saveUser() {
        $("#fm").form("submit", {
            url: url,
            onSubmit: function () {
                if ($('input[name="column4"]:checked').val() == "" || $('input[name="column4"]:checked').val() == null) {
                    $.messager.alert("系统提示", "请选择性别！");
                    return false;
                }
                if ($("#column5").combobox("getValue") == "" || $("#column5").combobox("getValue") == null) {
                    $.messager.alert("系统提示", "请选择身份证件类型！");
                    return false;
                }
                return $(this).form("validate");
            },
            success: function (result) {
                var result = eval('(' + result + ')');
                if (result.errres) {
                    $.messager.alert("系统提示", result.errmsg);
                    //resetValue();
                    $("#dlg").dialog("close");
                    $("#dg").datagrid("reload");
                } else {
                    $.messager.alert("系统提示", result.errmsg);
                    return;
                }
            }
        });
    }

    function closeUserDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function resetValue() {
        $("#column2").val("");
        $("#column3").val("");
        $("#man").prop('checked', false);
        $("#women").prop('checked', false);
        $("#column5").combobox("setValue", "");
        $("#column6").val("");
        $("#column7").datebox("setValue","");
        $("#column8").val("");
        $("#column9").val("");
    }

    function autoInput() {
        $("#column2").blur(function () {
            //alert("autoInputName");
            var name = $("#column2").val();
            //isIncludeSpace(name);
            var fullName = pinyin.getFullChars(name);
            $("#column3").val(fullName);
        })
        $("#column5").combobox({
            //相当于html >> select >> onChange事件
            onChange:function(){
                var idCardType = $("#column5").combobox("getValue");
                var idCard = $("#column6").val();
                var reg = /(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                if(idCardType == "居民身份证") {
                    $("#column6").validatebox('options').validType="idcard";
                    //$("#column6").attr("validType","idcard");
                }
                if($("#column5").combobox("getValue") == "居民身份证" && reg.test(idCard)) {
                    //alert("idCard");
                    var gender = parseInt(idCard.charAt(16)) % 2 == 1 ? "男" : "女";
                    var birthday2 = idCard.substring(6, 10) + "-" + idCard.substring(10, 12) +
                        "-" + idCard.substring(12, 14);
                    if(gender == "男") {
                        $("#man").prop('checked', true);
                    } else {
                        $("#women").prop('checked', true);
                    }
                    $("#column7").datebox("setValue",birthday2);
                } else {
                    $('input[name="column4"]:checked').prop('checked', false);
                    $("#column7").datebox("setValue","");
                }
            }
        });
        $("#column6").blur(function () {
            //alert("autoInputIdcard");
            var idCard = $("#column6").val();
            var reg = /(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            if($("#column5").combobox("getValue") == "居民身份证" && reg.test(idCard)) {
                //alert("idCard");
                var gender = parseInt(idCard.charAt(16)) % 2 == 1 ? "男" : "女";
                var birthday = idCard.substring(6, 10) + "-" + idCard.substring(10, 12) +
                                "-" + idCard.substring(12, 14);
                if(gender == "男") {
                    $("#man").prop('checked', true);
                } else {
                    $("#women").prop('checked', true);
                }
                $("#column7").datebox("setValue",birthday);
            }
        })
    }
    function isIncludeSpace(content) {
        /*if (content.indexOf(" ") == -1) {
            alert("没有空格");
            return true;
        } else {
            alert("有空格");
            return false;
        }*/
        var reg = /^((?!\s).)*$/;
        if(reg.test(content)) {
            alert("没有空格")
        } else {
            alert("有空格")
        }
    }
    function isPastBirthday() {
        $("#column7").datebox("textbox").blur(function () {
            alert("isPastBirthday");
            var birthday = $("#column7").datebox("getValue");
            alert(birthday);
            //var birthday = birthday.replaceAll("-","/");
            //alert(birthday);
            var inputDate = new Date(birthday);
            alert(inputDate);
            var currentDate = new Date();
            alert(currentDate);
            if(Date.parse(inputDate)>Date.parse(currentDate)) {
                alert("出生日期不能大于当前日期");
            }
        })
    }
</script>
</html>
