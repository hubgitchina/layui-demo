package com.xxx.core.easyrules;

import java.math.BigDecimal;

import org.jeasy.rules.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: SpecialHeadhuntingRule
 * @Description: 特殊猎头付款规则
 * @Author wangpeng
 * @Date 2020-07-06 14:36
 * @Version 1.0
 */
@Rule(name = "特殊猎头", description = "特殊猎头一次性收费，无尾款，尾款默认为0")
public class SpecialHeadhuntingRule {

	private static final Logger log = LoggerFactory.getLogger(SpecialHeadhuntingRule.class);

	@Condition
	public boolean isSpecialHeadhunting(@Fact("MoneyVo") MoneyVo moneyVo) {

		return moneyVo.getBusinessType() == 1;
	}

	@Action
	public void specialHeadhuntingAction(@Fact("MoneyVo") MoneyVo moneyVo) {

		log.info("进入特殊猎头业务规则");

		BigDecimal monthSalary = moneyVo.getMonthSalary();
		BigDecimal rate = moneyVo.getRate().movePointLeft(2);
		BigDecimal taxRate = moneyVo.getTaxRate().movePointLeft(2);

		BigDecimal bigMonth = new BigDecimal("12");

		BigDecimal firstPay = monthSalary.multiply(bigMonth).multiply(rate);

		BigDecimal firstPayInvoice = monthSalary.multiply(bigMonth)
				.multiply(new BigDecimal("0.01").add(rate));

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

		return 1;
	}
}
