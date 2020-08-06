<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑招聘-渠道售卖</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/root/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<style>
    .layui-form-label {
        width: 110px;
    }

    .text-center {
        text-align: center;
    }
</style>
<body>

<div class="layui-container" style="width: 100%;">
    <div class="layui-col-md12">
        <form lay-filter="othersForm" class="layui-form model-form">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>基本信息</legend>
            </fieldset>
            <input name="id" type="hidden"/>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">项目名称<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="projectName" maxlength="200" class="layui-input"
                               placeholder="请输入项目名称" value="${entity.projectName!}"
                               lay-verify="required" required>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">负责人<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="hidden" id="dutyPersonId_hidden" name="dutyPersonId_hidden" value="${entity.dutyPersonId!}">
                        <input type="text" id="dutyPerson" name="dutyPerson" value="${entity.dutyPerson!}"
                               placeholder="请选择负责人" class="layui-input" lay-verify="required" required readonly>
                    </div>
                </div>
                <div class="layui-inline">
                    <div class="layui-inline">
                        <button class="layui-btn" type="button" onclick="chooseUser()">选择负责人</button>
                    </div>
                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>客户</legend>
            </fieldset>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <button type="button" onclick="createCustom('','','','','')" class="layui-btn icon-btn"><i
                                class="layui-icon layui-icon-friends"></i>添加客户
                    </button>
                </div>
                <table class="layui-hide" id="custom_table" lay-filter="custom_table"></table>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>供应商</legend>
            </fieldset>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <button type="button" onclick="createSupplier('','','','','','')" class="layui-btn icon-btn"><i
                                class="layui-icon layui-icon-friends"></i>添加供应商
                    </button>
                </div>
                <table class="layui-hide" id="supplier_table" lay-filter="supplier_table"></table>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>统计</legend>
            </fieldset>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">税后总成本<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="afterTaxTotalCost" maxlength="20" class="layui-input"
                               placeholder="￥" value="${entity.afterTaxTotalCost?c}" readonly>
                    </div>
                </div>
                <div class="layui-inline" pane>
                    <label class="layui-form-label">税后总收入<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="afterTaxTotalIncome" maxlength="20" class="layui-input"
                               placeholder="￥" value="${entity.afterTaxTotalIncome?c}" readonly>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">合同总金额<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="contractTotalAmount" maxlength="20" class="layui-input"
                               placeholder="￥" value="${entity.contractTotalAmount?c}" readonly>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">总毛利润<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="totalGrossProfit" maxlength="20" class="layui-input"
                               placeholder="￥" value="${entity.totalGrossProfit?c}" readonly>
                    </div>
                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>备注</legend>
            </fieldset>
            <div class="layui-form-item layui-form-text">
                <div class="layui-input-block" style="margin-left: 0">
                        <textarea placeholder="请输入备注内容（限1000字内）" class="layui-textarea" id="remark" name="remark"
                                  maxlength="1000">${entity.remark!}</textarea>
                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>销售附件</legend>
            </fieldset>
            <div class="layui-upload">
                <button type="button" class="layui-btn layui-btn-normal" id="saleUpload">
                    <i class="layui-icon layui-icon-upload"></i>上传文件
                </button>
                <button type="button" class="layui-btn" id="saleAction" style="display: none">开始上传</button>
            </div>
            <div class="layui-form-item">
                <div class="layui-upload-list">
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th>文件名</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="saleTbody"></tbody>
                    </table>
                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>采购附件</legend>
            </fieldset>
            <div class="layui-upload">
                <button type="button" class="layui-btn layui-btn-normal" id="purchaseUpload">
                    <i class="layui-icon layui-icon-upload"></i>上传文件
                </button>
                <button type="button" class="layui-btn" id="purchaseAction" style="display: none">开始上传</button>
            </div>
            <div class="layui-form-item">
                <div class="layui-upload-list">
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th>文件名</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="purchaseTbody"></tbody>
                    </table>
                </div>
            </div>

            <div class="layui-form-item text-center">
                <input type="hidden" id="channelSaleId" value="${entity.id!}">
                <button class="layui-btn" lay-filter="formSubmit" lay-submit>保存</button>
                <button class="layui-btn layui-btn-primary" type="button" ew-event="cancelBtn" id="cancelBtn">
                    取消
                </button>
            </div>
        </form>
    </div>
</div>

<#-- 客户表格操作 -->
<script id="customBar" type="text/html">
    <button type="button" class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>
    <button type="button" class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>
</script>

<#-- 供应商表格操作 -->
<script id="supplierBar" type="text/html">
    <button type="button" class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>
    <button type="button" class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>
</script>

<script src="/root/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script type="text/javascript" src="/root/js/chooseRadioUser.js" charset="utf-8"></script>
<script charset="utf-8">

    var customTableData = new Array();
    var supplierTableData = new Array();

    layui.use(['form', 'table', 'layer', 'util', 'upload'], function () {
        var $ = layui.jquery;
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        var upload = layui.upload;
        var util = layui.util;

        var saleType = '${saleType}';
        var purchaseType = '${purchaseType}';

        <#list entity.customList as custom>
        var recordCustom = {
            id: '${custom.id!}'
            , customId: '${custom.customId!}'
            , customName: '${custom.customName!}'
            , contractAmount: '${custom.contractAmount?c}'
            , afterTaxIncome: '${custom.afterTaxIncome?c}'
        };
        customTableData.push(recordCustom);
        </#list>

        <#list entity.supplierList as supplier>
        var recordSupplier = {
            id: '${supplier.id!}'
            , supplierId: '${supplier.supplierId!}'
            , supplierName: '${supplier.supplierName!}'
            , purchaseAmount: '${supplier.purchaseAmount?c}'
            , taxRate: '${supplier.taxRate?c}'
            , afterTaxCost: '${supplier.afterTaxCost?c}'
        };
        supplierTableData.push(recordSupplier);
        </#list>

        var channelSaleId = $("#channelSaleId").val();

        //初始化销售附件表格数据
        initFileList(channelSaleId, saleType, "saleTbody");

        //初始化采购附件表格数据
        initFileList(channelSaleId, purchaseType, "purchaseTbody");

        // 渲染销售附件上传控件信息
        loadFileUpload("saleTbody", "saleUpload", "saleAction", saleType);

        // 渲染采购附件上传控件信息
        loadFileUpload("purchaseTbody", "purchaseUpload", "purchaseAction", purchaseType);

        // form.render();

        var customTable = table.render({
            limit: 10,
            elem: '#custom_table',
            data: customTableData,
            title: '客户列表',
            method: 'post',
            // width: '500',
            // height: '472',
            contentType: 'application/json',
            defaultToolbar: [],
            page: true,
            cols: [[
                {type: 'numbers', title: '序号', align: 'center'}
                , {field: 'id', title: 'ID', align: 'center', hide: true}
                , {field: 'customId', title: '客户ID', align: 'center', hide: true}
                , {field: 'customName', title: '客户名称', minWidth: 300, align: 'center'}
                , {field: 'contractAmount', title: '合同金额（元）', align: 'center'}
                , {field: 'afterTaxIncome', title: '税后收入（元）', align: 'center'}
                , {fixed: 'right', title: '操作', minWidth: 100, align: 'center', toolbar: '#customBar'}
            ]]
            , response: {
                statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
            }
            , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.total, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
        });

        var supplierTable = table.render({
            limit: 10,
            elem: '#supplier_table',
            data: supplierTableData,
            title: '供应商列表',
            method: 'post',
            // width: '500',
            // height: '472',
            contentType: 'application/json',
            defaultToolbar: [],
            page: true,
            cols: [[
                {type: 'numbers', title: '序号', align: 'center'}
                , {field: 'id', title: 'ID', align: 'center', hide: true}
                , {field: 'supplierId', title: '供应商ID', align: 'center', hide: true}
                , {field: 'supplierName', title: '供应商名称', minWidth: 300, align: 'center'}
                , {field: 'purchaseAmount', title: '采购金额（元）', align: 'center'}
                , {field: 'taxRate', title: '税率（%）', align: 'center'}
                , {field: 'afterTaxCost', title: '税后成本（元）', align: 'center'}
                , {fixed: 'right', title: '操作', minWidth: 100, align: 'center', toolbar: '#supplierBar'}
            ]]
            , response: {
                statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
            }
            , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.total, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
        });

        //监听客户列表行工具事件
        table.on('tool(custom_table)', function (obj) {
            var f = obj.data;
            if (obj.event === 'edit') {
                createCustom(f.id, f.customId, f.customName, f.contractAmount, f.afterTaxIncome);
            } else if (obj.event === 'del') {
                deleteCustomTableData(f.id);
                table.reload('custom_table', {data: customTableData});
            }
        });

        deleteCustomTableData = function (id) {
            customTableData = customTableData.filter(function (item) {
                return item.id != id
            });
            calculate();
        }

        createCustom = function (id, customId, customName, contractAmount, afterTaxIncome) {
            layer.open({
                type: 2,
                area: ['480px', '350px'],
                title: '添加客户',
                content: './createCustom?id=' + id + '&customId=' + customId + '&customName=' + customName + '&contractAmount=' + contractAmount + '&afterTaxIncome=' + afterTaxIncome
            });
        }

        //监听供应商列表行工具事件
        table.on('tool(supplier_table)', function (obj) {
            var f = obj.data;
            if (obj.event === 'edit') {
                createSupplier(f.id, f.supplierId, f.supplierName, f.purchaseAmount, f.taxRate, f.afterTaxCost);
            } else if (obj.event === 'del') {
                deleteSupplierTableData(f.id);
                table.reload('supplier_table', {data: supplierTableData});
            }
        });

        deleteSupplierTableData = function (id) {
            supplierTableData = supplierTableData.filter(function (item) {
                return item.id != id
            });
            calculate();
        }

        createSupplier = function (id, supplierId, supplierName, purchaseAmount, taxRate, afterTaxCost) {
            layer.open({
                type: 2,
                area: ['550px', '400px'],
                title: '添加供应商',
                content: './createSupplier?id=' + id + '&supplierId=' + supplierId + '&supplierName=' + supplierName + '&purchaseAmount=' + purchaseAmount + '&taxRate=' + taxRate + '&afterTaxCost=' + afterTaxCost
            });
        }

        calculate = function () {
            var contractTotalAmount = 0;
            var afterTaxTotalIncome = 0;
            var afterTaxTotalCost = 0;

            for (var i = 0, len = customTableData.length; i < len; i++) {
                contractTotalAmount += parseInt(customTableData[i].contractAmount);
                afterTaxTotalIncome += parseInt(customTableData[i].afterTaxIncome);
            }

            for (var i = 0, len = supplierTableData.length; i < len; i++) {
                afterTaxTotalCost += parseInt(supplierTableData[i].afterTaxCost);
            }

            var totalGrossProfit = afterTaxTotalIncome - afterTaxTotalCost;

            $("[name='contractTotalAmount']").val(contractTotalAmount);
            $("[name='afterTaxTotalIncome']").val(afterTaxTotalIncome);
            $("[name='afterTaxTotalCost']").val(afterTaxTotalCost);
            $("[name='totalGrossProfit']").val(totalGrossProfit);
        }

        // 表单提交事件
        form.on('submit(formSubmit)', function (d) {
            if (customTableData.length == 0) {
                layer.msg("请添加客户");
                return false;
            }

            if (supplierTableData.length == 0) {
                layer.msg("请添加供应商");
                return false;
            }

            // 组装数据
            var param = {
                id: channelSaleId
                , projectName: d.field.projectName
                , dutyPersonId: d.field.dutyPersonId_hidden
                , dutyPerson: d.field.dutyPerson
                , afterTaxTotalCost: d.field.afterTaxTotalCost
                , afterTaxTotalIncome: d.field.afterTaxTotalIncome
                , contractTotalAmount: d.field.contractTotalAmount
                , totalGrossProfit: d.field.totalGrossProfit
                , remark: d.field.remark
                , customList: customTableData
                , supplierList: supplierTableData
            };

            var msgIndex = layer.msg('系统处理中，请等待...', {shade: [0.8, '#393D49'], icon: 16, time: false});

            $.ajax({
                type: 'POST',
                url: '/channelsale/modifyChannelSale',
                contentType: "application/json; charset=utf-8",
                async: true,
                data: JSON.stringify(param),
                dataType: "json",
                success: function (res) {
                    layer.close(msgIndex);

                    if (res.code == 200) {

                        //触发附件上传
                        $("#saleAction").click();
                        $("#purchaseAction").click();

                        parent.layui.table.reload('recruit_table');
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭
                        parent.layer.msg("修改成功！", {icon: 1});
                    } else {
                        layer.alert("修改失败，" + res.msg, {
                            icon: 5,
                            btnAlign: 'c', //按钮居中
                            title: "提示"
                        });
                    }
                },
                error: function (msg) {
                    layer.close(msgIndex);

                    layer.alert("修改失败: " + msg, {
                        icon: 5,
                        btnAlign: 'c', //按钮居中
                        title: "提示"
                    });
                }
            });
            return false;
        });

        $(document).on('click', '#cancelBtn', function () {
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        });

        //初始化附件列表
        function initFileList(id, type, tbodyId) {
            $.ajax({
                url: '/file/fileList?correlatorId=' + id + '&type=' + type,
                type: "get"
                , async: false
                , dataType: "json"
                , success: function (res) {
                    if (res.code == 200) {
                        var ds = res.data;
                        if (ds.length > 0) {
                            for (var i = 0; i < ds.length; i++) {
                                (function (d) {
                                    var tr = $(['<tr id="' + d.fileId + '" name="' + d.fileUrl + '">'
                                        , '<td>' + d.fileName + '</td>'
                                        , '<td>已上传</td>'
                                        , '<td>'
                                        , '<button class="layui-btn layui-btn-xs layui-btn-danger data-delete">删除</button>'
                                        , '<button class="layui-btn layui-btn-xs data-download">下载</button>'
                                        , '</td>'
                                        , '</tr>'].join(''));
                                    //删除
                                    tr.find('.data-delete').on('click', function (param) {
                                        // delete files[index]; //删除对应的文件
                                        var fileId = tr.attr("id");
                                        var fileUrl = tr.attr("name");
                                        var tds = tr.children();
                                        var fileName = tds.eq(0).html();
                                        // 删除文件库中的文件
                                        $.post("/file/deleleFile", {
                                            fileId: fileId,
                                            fileUrl: fileUrl.substring(0, fileUrl.indexOf(fileName)) + "(" + fileId + ")" + fileUrl.substring(fileUrl.indexOf(fileName)),
                                            type: type
                                        }, function (res) {
                                            if (res.code == 200) {
                                                layer.msg("删除成功！");
                                                tr.remove();
                                            } else {
                                                layer.msg(res.msg);
                                            }
                                        });
                                        return false;
                                        // uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                                    });

                                    // 下载
                                    tr.find('.data-download').on('click', function () {
                                        var fileId = tr.attr("id");
                                        var fileUrl = tr.attr("name");
                                        var tds = tr.children();
                                        var fileName = tds.eq(0).html();
                                        var url = '/file/download';
                                        var option = {
                                            data: {
                                                fileId: fileId,
                                                fileUrl: fileUrl.substring(0, fileUrl.indexOf(fileName)) + "(" + fileId + ")" + fileUrl.substring(fileUrl.indexOf(fileName)),
                                                fileName: fileName
                                            }
                                        }
                                        $.get("/file/isExistFile", {fileUrl: fileUrl.substring(0, fileUrl.indexOf(fileName)) + "(" + fileId + ")" + fileUrl.substring(fileUrl.indexOf(fileName))}, function (res) {
                                            if (res.code == 200) {
                                                download(url, option);
                                            } else {
                                                layer.msg(res.msg, {icon: 2});
                                            }
                                        });
                                        return false;
                                    });
                                    $("#" + tbodyId).append(tr);
                                })(ds[i]);
                            }
                        }
                    }
                }
            });
        }

        //下载附件
        function download(url, options) {
            var opt = {
                method: "POST",
                data: null,
                timeout: 1000 * 60 * 2,
                onError: function (text) {
                    return text || "没有找到匹配的文件";
                },
            };
            $.extend(opt, options);

            var iframeName = "download-" + Date.now(),
                // 为了避免页面跳转，采用创建临时iframe的方式
                $iframe = $('<iframe name="' + iframeName + '" style="display:none;"></iframe>').appendTo(document.body);

            // 给iframe传递一个错误处理回调函数等遇到错误时调用
            $iframe[0].errorCallback = opt.onError;

            if (opt.method.toUpperCase() === "POST") { // POST 方式
                var iframeDoc = $iframe.prop("contentDocument") || $iframe.prop("contentWindow").document, // 获取iframe的document对象
                    $form = null,
                    data = opt.data;
                // 为iframe写入一个form元素，利用该form元素发起文件下载请求
                iframeDoc.write('<form method="POST" action="' + url + '"></form>');
                $form = $(iframeDoc).find("form"); // 获取该form元素
                // 带请求参数的情况
                if (data instanceof Object) {
                    if (Array.isArray(data)) { // data是数组形式
                        data.forEach(function (o) {
                            if (o.value) $("<input>").prop(o).appendTo($form);
                        });
                    } else { // data是对象形式
                        for (var n in data) {
                            $("<input>").prop({name: n, value: data[n]}).appendTo($form);
                        }
                    }
                }
                // 提交表单
                $form.submit();
            } else { // 默认 GET 方式
                url.indexOf("?") < 0 ? url += "?" : url += "&";
                window.open(url + $.param(opt.data), iframeName);
            }

            // 移除临时iframe
            setTimeout(function () {
                $iframe.remove();
            }, opt.timeout);
        }

        function loadFileUpload(tbodyId, elemId, bindButtonId, type) {
            //多文件列表示例
            var demoListView = $("#" + tbodyId)
                , uploadListIns = upload.render({
                elem: '#' + elemId
                , url: '/file/upload/'
                , accept: 'file'
                , size: 10240
                , multiple: true
                , number: 5
                , auto: false
                , bindAction: '#' + bindButtonId
                , data: {
                    id: function () {
                        return $("#channelSaleId").val();
                    },
                    type: type
                }
                , before: function (obj) {

                }
                , choose: function (obj) {
                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列

                    //读取本地文件
                    obj.preview(function (index, file, result) {
                        var tr = $(['<tr id="upload-' + index + '">'
                            , '<td>' + file.name + '</td>'
                            , '<td>等待上传</td>'
                            , '<td>'
                            , '<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                            , '<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                            , '</td>'
                            , '</tr>'].join(''));

                        //单个重传
                        tr.find('.demo-reload').on('click', function () {
                            obj.upload(index, file);
                            return false;
                        });

                        //删除
                        tr.find('.demo-delete').on('click', function () {
                            delete files[index]; //删除对应的文件
                            tr.remove();
                            uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                        });

                        demoListView.append(tr);
                    });
                }
                , done: function (res, index, upload) {
                    layer.close(layer.index);
                    if (res.code == 200) { //上传成功
                        var file = res.data;
                        console.log(file);
                        var tr = demoListView.find('tr#upload-' + index)
                            , tds = tr.children();
                        tds.eq(1).html('<span style="color: #5FB878;">上传成功</span>');
                        tds.eq(2).html(''); //清空操作按钮
                        return delete this.files[index]; //删除文件队列已经上传成功的文件
                    }
                    this.error(index, upload);
                }
                , error: function (index, upload) {
                    var tr = demoListView.find('tr#upload-' + index)
                        , tds = tr.children();
                    tds.eq(1).html('<span style="color: #FF5722;">上传失败</span>');
                    tds.eq(2).find('.demo-reload').removeClass('layui-hide'); //显示重传
                }
            });
        }

    });
</script>
</body>
</html>