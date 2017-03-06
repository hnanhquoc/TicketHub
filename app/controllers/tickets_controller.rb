class TicketsController < ApplicationController
	def new
		@event = Event.find(params[:event_id])
	end

	def buy
		if params[:id] && params[:quantity]
			@ticket_type = TicketType.find_by_id(params[:id])
			if !TicketType.update(@ticket_type.id, max_quantity: @ticket_type.max_quantity - params[:quantity].to_i)
				flash[:error] = "Error: #{@order.errors.full_messages.to_sentence}"
				render 'new'
				return
			end
			@orders = Order.where("ticket_type_id = ? and email = ?", params[:id], current_user.email)
			if (@orders.nil? || @orders.empty?)
				@order = Order.new ticket_type_id: params[:id], quantity: params[:quantity], email: current_user.email
				if @order.save!
					flash[:success] = "Buy " + params[:quantity] + " ticket(s) successful!"
					redirect_to new_event_ticket_path
				else
					flash[:error] = "Error: #{@order.errors.full_messages.to_sentence}"
					render 'new'
				end
			else
				@order = @orders[0]
				quantity = @order.quantity + params[:quantity].to_i
				if Order.update(@order.id, quantity: quantity)
					flash[:success] = "Buy " + params[:quantity] + " ticket(s) successful! Total: " + quantity.to_s + " tickets."
					redirect_to new_event_ticket_path
				else
					flash[:error] = "Error: #{@order.errors.full_messages.to_sentence}"
					render 'new'
				end
			end
		else
			flash[:error] = "Empty params"
			render 'new'
		end
	end

	def ticket_params
		params.require(:ticket).permit(:id, :event_id, :quantity)
	end
end
