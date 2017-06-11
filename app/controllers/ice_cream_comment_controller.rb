class IceCreamCommentController < ApplicationController
    
    def show_comments
        @selected_ice_cream = IceCream.find(params[:ice_cream_id])
        @comments = IceCreamComment.where(:ice_cream_id => params[:ice_cream_id])
    
    end
    
    #comment creation action
    def create
        @comment = IceCreamComment.new
        @comment.content = params[:comment_input_content]
        @comment.ice_cream_id = params[:ice_cream_id]
        @comment.save
        
        redirect_to "/ice_cream_comment/show_comments/#{params[:ice_cream_id]}"
    end
    
    # #comment destroy action
    # def destroy
    #     @comment = Comment.find(params[:comment_id]) #코멘트아이디 
    #     @comment.destroy
    #     redirect_to "/posts/show/#{params[:post_id]}"
    # end
    
end
