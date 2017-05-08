package com.plan.plan;

import java.util.List;

import com.plan.big.BigDTO;
import com.plan.city.CityDTO;
import com.plan.dayPlan.DayPlanDTO;
import com.plan.dayPlan.DayPlanReDTO;
import com.plan.daySpot.DaySpotDTO;
import com.plan.daySpot.DaySpotReDTO;
import com.plan.member.MemberDTO;
import com.plan.planRe.PlanReDTO;
import com.plan.scrap.ScrapDTO;
import com.plan.spot.SpotDTO;

public interface PlanService {
	
	public List<BigDTO> s_bigCity_list();
	
	public List<CityDTO> s_gang_list();
	
	public List<CityDTO> s_gyeong_list();
	
	public List<CityDTO> s_gyeongsangS_list();
	
	public List<CityDTO> s_gyeongsangN_list();
	
	public List<CityDTO> s_chungcheongS_list();
	
	public List<CityDTO> s_chungcheongN_list();
	
	public List<CityDTO> s_jeollaS_list();
	
	public List<CityDTO> s_jeollaN_list();
	
	public void s_plan_insert(PlanDTO planDTO);
	
	public int s_plan_no();
	
	public void s_dayPlan_insert(DayPlanDTO dayPlanDTO);
	
	public List<DayPlanReDTO> s_get_dayPalnReDTO(DayPlanReDTO dayPlanReDTO);
	
	public PlanDTO s_get_planDTOone(PlanDTO planDTO);
	
	public List<SpotDTO> s_get_pspotList(int city_no);
	
	public void s_plan_save_update(PlanDTO planDTO);
	
	public void s_get_daily_update(DayPlanDTO dayPlanDTO);
	
	public void s_daySpot_insert(DaySpotDTO daySpotDTO);
	
	public MemberDTO s_writer_search(String id);
	
	public PlanDTO s_plan_search(int plan_no);
	
	public List<DayPlanReDTO> s_daily_plan_search(int plan_no);
	
	public List<DaySpotReDTO> s_daily_spot_search(int plan_no, int daily_no);

	public PlanReDTO s_plan_reply_write(PlanReDTO planReDTO);
	
	public List<PlanReDTO> s_plan_reply_list(int plan_no);
	
	public List<PlanReDTO> s_plan_reply_del(PlanReDTO planReDTO);
	
	public void s_plan_fdate_update(PlanDTO planDTO);
	
	public void s_plan_spot_del(PlanDTO planDTO);
	
	public List<DayPlanReDTO> s_day_plan_del(DayPlanReDTO dayPlanReDTO);
	
	public List<NewPlanDTO> s_plan_list_select(PlanMakePage planMakePage);
	
	public int s_spot_counts(PlanDTO planDTO);
	
	public int s_clip_counts(PlanDTO planDTO);
	
	public List<String> s_get_city_names(PlanDTO planDTO);
	
	public List<CityDTO> s_city_list_all();
	
	public List<NewPlanDTO> s_plan_list_ajax(NewPlanDTO newPlanDTO);
	
	public void s_plan_jim_insert(ScrapDTO scrapDTO);
	
	public ScrapDTO s_plan_jim_select(ScrapDTO scrapDTO);
	
	public void s_plan_jim_delete(ScrapDTO scrapDTO);
	
	public int s_plan_list_counts();

	public List<NewPlanDTO> s_select_complite_plan(NewPlanDTO newPlanDTO);
	
	public List<NewPlanDTO> s_select_incomplite_plan(NewPlanDTO newPlanDTO);
	
	public void s_del_my_plan(PlanDTO planDTO);
}
