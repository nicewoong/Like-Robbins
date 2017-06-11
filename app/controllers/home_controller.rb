class HomeController < ApplicationController

  # Main page
  def index
    
  end
  
  #ice cream 둘 중에 하나 선택하는 창으로 가는 액션 
  def versus
    @progressNumber = 0
    logger.info "========================== versus Action이 시작됩니다.  "
    @cup_size = params[:cup_size]
    @chosenIceCreamArray = [] #전체 아이스크림 number 를 배열에 담아 초기화 할거에요. 
    @allIceCreams = IceCream.all #db에서 모두 불러와요. 
    @allIceCreams.each do |eachIceCream| #반복문을 돌려서 number들을 모두 담아요. 
      @chosenIceCreamArray.append(eachIceCream.number)
    end
    
    #ice cream 목록 중에 몇 번째 아이스크림을 가르킬 건지 index  => 0으로 초기화
    @iceCreamArrayIndex = 0; 
    
    #현재의 두 개 아이스크림 뭔지 알려줄게 
    @left_ice_cream = IceCream.where(:number=>@chosenIceCreamArray[@iceCreamArrayIndex]).take#왼쪽 아이스크림
    @right_ice_cream = IceCream.where(:number=>@chosenIceCreamArray[@iceCreamArrayIndex+1]).take #오른쪽 아이스크림
    
  end
  
  #ice cream 하나를 선택했을 때. 
  def choose_one
    
    logger.info "========================== Choose_one 시작했어요. "
    @cup_size = params[:cup_size]
    logger.info @cup_size
    
    @allIceCreams = IceCream.all #db에서 모두 불러와요. 
    
    @chosenIceCreamArray = eval(params[:chosenIceCreamsParam]) #문자열 형태의 "[1,2,3, ... ,n]" 배열을 array변수로 변경
    logger.info @chosenIceCreamArray # 배열을 로그로 확인해봅시다. 
    
    @iceCreamArrayIndex = params[:removeIndex].to_i
    @chosen_side = params[:chosen_side] #선택된 아이스크림 방향 (left or right)
    logger.info @iceCreamArrayIndex
    
    

    #선택안된녀석 삭제. (둘 중에 선택 안된 녀석을 지우는 것임!)ㄴ
    if @chosen_side == "right" #오른쪽을 선택했으면 current index 를 삭제
      @chosenIceCreamArray.delete_at(@iceCreamArrayIndex) #해당 index의 element를 배열에서 제거합니다. 
    else #왼쪽을 선택했으면 current index +1 를 삭제. 
      @chosenIceCreamArray.delete_at(@iceCreamArrayIndex+1) #해당 index의 element를 배열에서 제거합니다. 
    end
    
    
    logger.info "========================== 선택안된거 제거했어효. "
    logger.info @chosenIceCreamArray # 배열을 로그로 확인해봅시다. 
    
    @iceCreamArrayIndex += 1 #다음 두 아이스크림을 고를 수 있도록 인덱스를 증가. 
    
    
    if @iceCreamArrayIndex >=  @chosenIceCreamArray.length #남은 후보 갯수보다 index가 커지면 다시 처음으로 돌아가야함
      @iceCreamArrayIndex=0 # 16강전->8강전으로 0부터 다시시작! 
    end
    
    
    
    #현재의 두 개 아이스크림 뭔지 알려줄게 
    @left_ice_cream = IceCream.where(:number=>@chosenIceCreamArray[@iceCreamArrayIndex]).take#왼쪽 아이스크림
    @right_ice_cream = IceCream.where(:number=>@chosenIceCreamArray[@iceCreamArrayIndex+1]).take #오른쪽 아이스크림
    
    if @chosenIceCreamArray.length >=16
      @round=16
      elsif @chosenIceCreamArray.length >=8 &&  @chosenIceCreamArray.length <16
      @round=8
      elsif @chosenIceCreamArray.length >=4 &&  @chosenIceCreamArray.length <8
      @round=4
    end 
    
    @progressPercentage = (@iceCreamArrayIndex+1)*100/@round
    logger.info @progressPercentage 
    
    if @chosenIceCreamArray.length <= 4 #네개 남으면 끝! 최종선택된 화면으로 이동!
      if @cup_size=="quater"
        render "final_choice_quater"
        final_choice_count(@chosenIceCreamArray) #최종선택된 것 count해주는 함수에요. 
      elsif @cup_size=="pint"
        render "sorry" # 4개 중 한개 제외해야해요. => sorry.html.erb로 이동하자! 
      end
    else
      render "versus"
    end
    
    logger.info "========================== choose_one 끝 "
    
  end
  
  #4개 남앗을 때 => 1개 빼고나서. 최종 3개 파인트 보여주는 액션
  def final_choice_pint

    logger.info "========================== final_choice_pint 시작이용  "
    @removeItemIndex = params[:radio_item_index].to_i
    @allIceCreams = IceCream.all #db에서 모두 불러와요. 
    
    @chosenIceCreamArray = eval(params[:chosenIceCreams]) #문자열 형태의 "[1,2,3, ... ,n]" 배열을 array변수로 변경
  
    logger.info @chosenIceCreamArray # 배열을 로그로 확인해봅시다. 
    
    #선택된녀석을 삭제하자! 
    @chosenIceCreamArray.delete_at(@removeItemIndex) #해당 index의 element를 배열에서 제거합니다. 
  
    logger.info "========================== 삭제후"
    logger.info @chosenIceCreamArray # 배열을 로그로 확인해봅시다. 
    final_choice_count(@chosenIceCreamArray) #최종선택된 것 count해주는 함수에요. 
    render "final_choice_pint"
  end
  
  
  #32강의 모든 아이스크림을 쭈루룩 보여줄거에요. 
  def all_icecream
    @allIceCreams = IceCream.all #db에서 모두 불러와요. 
    
    
  end
  
  
  #최종 선택된 아이스크림에 대해서 selectedCount를 증가시켜줍니다. 
  def final_choice_count(chosenIceCreamArray)
    logger.info "========================== 최종선택된 것을 기록해서 count를 증가시켜줘요"
    logger.info chosenIceCreamArray # 배열을 로그로 확인해봅시다. 
    
    chosenIceCreamArray.each do |eachIceCreamNumber|
      iceCreamObject = IceCream.where(:number=>eachIceCreamNumber ).take
      iceCreamObject.selectedCount += 1
      iceCreamObject.save
    end
  end
  


end
