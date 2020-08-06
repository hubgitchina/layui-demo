<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>新增招聘-渠道售卖</title>
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
                               placeholder="请输入项目名称"
                               lay-verify="required" required>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">负责人<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="dutyPerson" maxlength="20" class="layui-input"
                               placeholder="请输入负责人"
                               lay-verify="required" required>
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
                               placeholder="￥" readonly>
                    </div>
                </div>
                <div class="layui-inline" pane>
                    <label class="layui-form-label">税后总收入<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="afterTaxTotalIncome" maxlength="20" class="layui-input"
                               placeholder="￥" readonly>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">合同总金额<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="contractTotalAmount" maxlength="20" class="layui-input"
                               placeholder="￥" readonly>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">总毛利润<b style="color:red">*</b></label>
                    <div class="layui-input-inline">
                        <input type="text" name="totalGrossProfit" maxlength="20" class="layui-input"
                               placeholder="￥" readonly>
                    </div>
                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>备注</legend>
            </fieldset>
            <div class="layui-form-item layui-form-text">
                <div class="layui-input-block" style="margin-left: 0">
                        <textarea placeholder="请输入备注内容（限1000字内）" class="layui-textarea" id="remark" name="remark"
                                  maxlength="1000"></textarea>
                </div>
            </div>
            <div class="layui-form-item text-center">
                <input type="hidden" id="channelSaleId" value="">
                <button class="layui-btn" lay-filter="formSubmit" lay-submit>保存</button>
                <button class="layui-btn layui-btn-primary" type="button" ew-event="cancelBtn" id="cancelBtn">
                    取消
                </button>
            </div>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>销售附件</legend>
            </fieldset>
            <div class="layui-upload">
                <button type="button" class="layui-btn layui-btn-normal" id="saleUpload">上传文件</button>
                <button type="button" class="layui-btn" id="saleAction">开始上传</button>
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
                <button type="button" class="layui-btn layui-btn-normal" id="purchaseUpload">上传文件</button>
                <button type="button" class="layui-btn" id="purchaseAction">开始上传</button>
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
<script src="/root/js/server-api.js" charset="utf-8"></script>
<script src="/root/form/form-verify.js" charset="utf-8"></script>
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

        // var channelSaleId = $("#channelSaleId").val();
        var saleType = '${saleType}';
        var purchaseType = '${purchaseType}';

        // 渲染销售附件上传控件信息
        loadFileUpload("saleTbody", "saleUpload", "saleAction", saleType, 0);

        // 渲染采购附件上传控件信息
        loadFileUpload("purchaseTbody", "purchaseUpload", "purchaseAction", purchaseType, 0);

        // form.render();

        // layui.customTableData = new Array();
        // layui.supplierTableData = new Array();

        // var customTableData = layui.customTableData;
        // var supplierTableData = layui.supplierTableData;

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

        var customTable = table.render({
            limit: 10,
            elem: '#supplier_table',
            data: supplierTableData,
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
                , {field: 'supplierId', title: '供应商ID', align: 'center', hide: true}
                , {field: 'supplierName', title: '供应商名称', minWidth: 300, align: 'center'}
                , {field: 'purchaseAmount', title: '采购金额（元）', align: 'center'}
                , {field: 'taxRate', title: '税率（元）', align: 'center'}
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
                projectName: d.field.projectName
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
                url: '/channelsale/createChannelSale',
                contentType: "application/json; charset=utf-8",
                async: true,
                data: JSON.stringify(param),
                dataType: "json",
                success: function (res) {
                    layer.close(msgIndex);

                    if (res.code == 200) {
                        $("#channelSaleId").val(res.data);
                        parent.layui.table.reload('recruit_table');
                        // var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        // parent.layer.close(index); //再执行关闭
                        parent.layer.msg("新增成功！", {icon: 1});
                    } else {
                        layer.alert("新增失败，" + res.msg, {
                            icon: 5,
                            btnAlign: 'c', //按钮居中
                            title: "提示"
                        });
                    }
                },
                error: function (msg) {
                    layer.close(msgIndex);

                    layer.alert("新增失败: " + msg, {
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

        function loadFileUpload(tbodyId, elemId, bindButtonId, type, fileNum) {
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
                    
                    if (fileNum == 0) {
                        layer.msg("请先选择需要上传的文件");
                        return false;
                    }

var msgIndex = layer.msg('系统处理中，请等待...', {shade: [0.8, '#393D49'], icon: 16, time: false});
                }
                , choose: function (obj) {
                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列

                    var channelSaleId = $("#channelSaleId").val();
                    if (!channelSaleId) {
                        layer.msg("请先保存渠道售卖主体信息");
                        for (var f in files) {
                            delete files[f];
                        }
                        return false;
                    }

                    //读取本地文件
                    obj.preview(function (index, file, result) {
                        fileNum++;
                        var tr = $(['<tr id="upload-' + index + '">'
                            , '<td>' + file.name + '</td>'
                            , '<td>等待上传</td>'
                            , '<td>'
                            , '<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                            , '<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
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
                        delete this.files[index]; //删除文件队列已经上传成功的文件
                        fileNum--;
                        return false;
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