package com.xxx.core.easyrules;

import java.math.BigDecimal;

import org.jeasy.rules.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: RpoRule
 * @Description: RPO付款规则
 * @Author wangpeng
 * @Date 2020-07-06 14:36
 * @Version 1.0
 */
@Rule(name = "RPO", description = "RPO一次性收费，无尾款，尾款默认为0")
public class RpoRule {

	private static final Logger log = LoggerFactory.getLogger(RpoRule.class);

	@Condition
	public boolean isRpo(@Fact("MoneyVo") MoneyVo moneyVo) {

		return moneyVo.getBusinessType() == 2;
	}

	@Action
	public void rpoAction(@Fact("MoneyVo") MoneyVo moneyVo) {

		log.info("进入RPO业务规则");

		BigDecimal monthSalary = moneyVo.getMonthSalary();
		BigDecimal rate = moneyVo.getRate().movePointLeft(2);
		BigDecimal taxRate = moneyVo.getTaxRate().movePointLeft(2);

		BigDecimal firstPay = monthSalary.multiply(rate);

		BigDecimal firstPayInvoice = monthSalary.multiply(new BigDecimal("0.1").add(rate));

		BigDecimal afterTaxIncome = firstPayInvoice.divide(new BigDecimal("1.06"), 2,
				BigDecimal.ROUND_HALF_UP);

		BigDecimal afterTaxCost = firstPay.divide(new BigDecimal("1").add(taxRate), 2,
				BigDecimal.ROUND_HALF_UP);

		BigDecimal grossProfit = afterTaxIncome.subtract(afterTaxCost);

		moneyVo.setFirstPay(firstPay);
		moneyVo.setEndPay(BigDecimal.ZERO);
		moneyVo.setFirstPayInvoice(firstPayInvoice);
		moneyVo.setEndPayInvoice(BigDecimal.ZERO);
		moneyVo.setAfterTaxIncome(afterTaxIncome);
		moneyVo.setAfterTaxCost(afterTaxCost);
		moneyVo.setGrossProfit(grossProfit);
	}

	@Priority
	public int getPriority() {

		return 2;
	}
}
