function initCustomTable(bankAccount){
        table.render({
            limit: 10,
            elem: '#custom_table',
            data:[],
            title: '开票客户银行信息单选列表',
            method: 'get',
            // height: '472',
            page: false,
            cols: [[
                {type: 'radio'}
                , {field: 'id', title: 'ID', align: 'center', hide: true}
                , {field: 'customName', title: '名称', align: 'center'}
                , {field: 'sapTaxNum', title: '税码', align: 'center'}
                , {field: 'customAddress', title: '地址', align: 'center'}
                , {field: 'customPhone', title: '电话', align: 'center'}
                , {field: 'customBank', title: '开户行', align: 'center'}
                , {field: 'bankAccount', title: '银行账号', align: 'center'}
            ]]
            , response: {
                statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
            }
            , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据
                setCheckedStatus(res, bankAccount);
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.total, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
            , done: function(res, curr, count){
                if(isHideCol){
                    setTableChecked(res, bankAccount);
                }
            }
        });
    }

    /**
     * 查看时设置指定选中之外其它列禁用效果
     * @param res
     * @param bankAccount
     */
    function setTableChecked(res, bankAccount){
        var newData = res.data;

        if (bankAccount != undefined) {
            for (var j = 0; j < newData.length; j++) {
                if (newData[j].bankAccount != bankAccount) {
                    var radioDivObj = $('div[lay-id=custom_table]').find('.layui-table-body .layui-table').find('tr[data-index=' + j + '] .layui-form-radio');
                    radioDivObj.addClass('layui-radio-disbaled layui-disabled');

                    var  radioObj= $('.layui-table tr[data-index=' + j + '] input[type="radio"]');
                    radioObj.prop("disabled",true);
                }
            }
        }
    }

/**
     * 查看时设置指定选中效果
     * @param res
     * @param bankAccount
     */
    function setCheckedStatus(res, bankAccount) {
        //默认勾上选中的数据
        var newData = res.data;

        if (bankAccount != undefined) {
            for (var j = 0; j < newData.length; j++) {
                if (newData[j].bankAccount == bankAccount) {
//选中
                    newData[j]["LAY_CHECKED"] = true;
                }
            }
        }
    }