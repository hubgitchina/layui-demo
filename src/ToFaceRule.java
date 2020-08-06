package com.xxx.core.easyrules;

import java.math.BigDecimal;

import org.jeasy.rules.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: ToFaceRule
 * @Description: 到面付款规则
 * @Author wangpeng
 * @Date 2020-07-06 14:36
 * @Version 1.0
 */
@Rule(name = "到面", description = "到面为固定金额，首款（付款）为2500，首款（开票）为2700,无尾款")
public class ToFaceRule {

	private static final Logger log = LoggerFactory.getLogger(ToFaceRule.class);

	@Condition
	public boolean isToFace(@Fact("MoneyVo") MoneyVo moneyVo) {

		return moneyVo.getBusinessType() == 3;
	}

	@Action
	public void toFaceAction(@Fact("MoneyVo") MoneyVo moneyVo) {

		log.info("进入到面业务规则");

		moneyVo.setFirstPay(new BigDecimal("2500"));
		moneyVo.setEndPay(BigDecimal.ZERO);
		moneyVo.setFirstPayInvoice(new BigDecimal("2700"));
		moneyVo.setEndPayInvoice(BigDecimal.ZERO);
		moneyVo.setAfterTaxIncome(BigDecimal.ZERO);
		moneyVo.setAfterTaxCost(BigDecimal.ZERO);
		moneyVo.setGrossProfit(BigDecimal.ZERO);
	}

	@Priority
	public int getPriority() {

		return 3;
	}
}
