package com.xxx.core.service.easyrules;

import java.math.BigDecimal;

import org.jeasy.rules.api.Facts;
import org.jeasy.rules.api.Rules;
import org.jeasy.rules.api.RulesEngine;
import org.jeasy.rules.api.RulesEngineParameters;
import org.jeasy.rules.core.DefaultRulesEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


/**
 * @ClassName: EasyRulesService
 * @Description: EasyRules规则引擎服务类
 * @Author wangpeng
 * @Date 2020-07-06 14:35
 * @Version 1.0
 */
@Service
public class EasyRulesService {

	private static final Logger log = LoggerFactory.getLogger(EasyRulesService.class);

	private static final RulesEngineParameters parameters;

	private static final RulesEngine rulesEngine;

	private static final Rules rules;

	static {
		log.info("Easy Rules规则引擎启动，初始化规则配置");

		/**
		 * 创建规则执行引擎 注意: skipOnFirstAppliedRule意思是，只要匹配到第一条规则就跳过后面规则匹配
		 */
		parameters = new RulesEngineParameters().skipOnFirstAppliedRule(true);
		rulesEngine = new DefaultRulesEngine(parameters);

		// 创建规则
		rules = new Rules();
		rules.register(new CommonHeadhuntingRule());
		rules.register(new SpecialHeadhuntingRule());
		rules.register(new RpoRule());
		rules.register(new ToFaceRule());
	}

	/**
	 * @Author wangpeng
	 * @Description 通过规则引擎计算金额数据
	 * @Date 15:09
	 * @Param
	 * @return
	 */
	public void calculateMoney(MoneyVo moneyVo) {

		Facts facts = new Facts();
		facts.put("MoneyVo", moneyVo);
		// 执行规则
		rulesEngine.fire(rules, facts);

		log.info("首款（付款）：" + moneyVo.getFirstPay());
		log.info("尾款（付款）：" + moneyVo.getEndPay());
		log.info("首款（开票）：" + moneyVo.getFirstPayInvoice());
		log.info("尾款（开票）：" + moneyVo.getEndPayInvoice());
		log.info("税后收入：" + moneyVo.getAfterTaxIncome());
		log.info("税后成本：" + moneyVo.getAfterTaxCost());
		log.info("毛利润：" + moneyVo.getGrossProfit());
	}

	public static void main(String[] args) {

		/**
		 * 创建规则执行引擎 注意: skipOnFirstAppliedRule意思是，只要匹配到第一条规则就跳过后面规则匹配
		 */
		RulesEngineParameters parameters = new RulesEngineParameters().skipOnFirstAppliedRule(true);
		RulesEngine rulesEngine = new DefaultRulesEngine(parameters);

		// try {
		// MVELRuleFactory ruleFactory = new MVELRuleFactory(new
		// YamlRuleDefinitionReader());
		// File file = ResourceUtils.getFile("classpath:recruit-rule.yml");
		// Reader reader = new FileReader(file);
		// Rules rules = ruleFactory.createRules(reader);
		// } catch (Exception e) {
		// e.printStackTrace();
		// }

		// 创建规则
		Rules rules = new Rules();
		rules.register(new CommonHeadhuntingRule());
		rules.register(new SpecialHeadhuntingRule());
		rules.register(new RpoRule());
		rules.register(new ToFaceRule());

		Facts facts = new Facts();

		MoneyVo moneyVo = new MoneyVo();
		moneyVo.setBusinessType(1);
		moneyVo.setChargeAmount(new BigDecimal("1000"));
		moneyVo.setMonthSalary(new BigDecimal("10000"));
		moneyVo.setRate(new BigDecimal("1"));
		moneyVo.setTaxRate(new BigDecimal("6"));

		facts.put("MoneyVo", moneyVo);
		// 执行规则
		rulesEngine.fire(rules, facts);

		System.out.println("首款（付款）：" + moneyVo.getFirstPay());
		System.out.println("尾款（付款）：" + moneyVo.getEndPay());
		System.out.println("首款（开票）：" + moneyVo.getFirstPayInvoice());
		System.out.println("尾款（开票）：" + moneyVo.getEndPayInvoice());
		System.out.println("税后收入：" + moneyVo.getAfterTaxIncome());
		System.out.println("税后成本：" + moneyVo.getAfterTaxCost());
		System.out.println("毛利润：" + moneyVo.getGrossProfit());

		// for (int i=1 ; i<=50 ; i++){
		// //规则因素，对应的name，要和规则里面的@Fact 一致
		// facts.put("number", i);
		// //执行规则
		// rulesEngine.fire(rules, facts);
		// System.out.println();
		// }
	}
}
