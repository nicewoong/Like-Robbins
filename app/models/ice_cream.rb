class IceCream < ActiveRecord::Base
    # 하나의 iceCream 에 다수의 comments가 연결됨. 
    has_many :ice_cream_comments, dependent: :destroy #:dependent => :destroy 와 같음 >>post삭제할 때 comments도 함께 삭제 
    
end
