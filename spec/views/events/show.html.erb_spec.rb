require 'rails_helper'

RSpec.describe "events/show", type: :view do
	before do
		# Create Regions
		['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong'].each do |r|
			Region.create(name: r)
		end
		
	# Create Categories
	['Entertainment', 'Learning', 'Everything Else'].each do |c|
		Category.create(name: c)
	end
	dalat = Venue.create({
		name: 'Da Lat City',
		full_address: 'Ngoc Phat Hotel 10 Hồ Tùng Mậu Phường 3, Thành phố Đà Lạt, Lâm Đồng, Thành Phố Đà Lạt, Lâm Đồng',
		region: Region.find_by(name: 'Lam Dong')
		})

	e = Event.create({
		name: 'Việt Nam Thử Thách Chiến Thắng', 
		starts_at: DateTime.parse('Fri, 11 Mar 2017 7:00 AM+0700'),
		ends_at: DateTime.parse('Sun, 13 Mar 2017 3:00 PM+0700'),
		venue: dalat,
		category: Category.find_by(name: 'Everything Else'),
		hero_image_url: 'https://media.ticketbox.vn/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter',
		extended_html_description: <<-DESC
		<p style="text-align:center"><span style="font-size:20px">VIỆT NAM THỬ THÁCH CHIẾN THẮNG 2016</span></p>
		<p style="text-align:center"><span style="font-size:20px">Giải đua xe đạp địa hình 11-13/03/2016</span></p>
		<p style="text-align:center"><span style="font-size:16px"><span style="font-family:arial,helvetica,sans-serif">Việt Nam Th</span>ử Thách Chiến Thắng là giải đua xe đạp địa hình được tổ chức như một sự tri ân, và cũng nhằm thỏa mãn lòng đam mẹ của những người yêu xe đạp địa hình nói chung, cũng như cho những ai đóng góp vào môn thể thao đua xe đạp tại thành phố Hồ Chí Minh. Cuộc đua diễn ra ở thành phố cao nguyên hùng vĩ Đà Lạt, với độ cao 1,500m (4,900ft) so với mặt nước biển. Đến với đường đua này ngoài việc tận hưởng cảnh quan nơi đây, bạn còn có cơ hội biết thêm về nền văn hóa của thành phố này. </span></p>
		<p style="text-align:center"><span style="font-size:16px">Hãy cùng với hơn 350 tay đua trải nghiệm 04 lộ trình đua tuyệt vời diễn ra trong 03 ngày tại Đà Lạt và bạn sẽ có những kỉ niệm không bao giờ quên!</span></p>
		<p style="text-align:center"><span style="font-size:16px">Để biết thêm thông tin chi tiết và tạo thêm hứng khởi cho cuộc đua 2016, vui lòng ghé thăm trang web</span></p>
		<p style="text-align:center"><span style="font-size:16px"><strong><span style="background-color:transparent; color:rgb(0, 0, 0)">www.vietnamvictorychallenge.com. </span></strong></span></p>
		DESC
		})
	e.ticket_types << TicketType.create(name: '2016 Việt Nam Thử Thách Chiến Thắng dành cho những tay đua đăng kí sớm.', price: 500000, max_quantity: 95)
	e.ticket_types << TicketType.create(name: 'Việt Nam Thử Thách Chiến Thắng ( Giá chính thức)', price: 2000000, max_quantity: 5)
	end

it "should have slide bar with Book Now button" do
		# event = Event.create!(name: "Michael Jackson", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " a current event",
		# 	venue: Venue.new, category: Category.new)
		render
		expect(rendered).to include('<button class="btn btn-lg btn-block btn-danger"> BOOK NOW </button>')
	end

  # it "should have slide bar with disabled Book Now button for a past event" do
  # 	event = Event.create!(name: "Michael Jackson", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a current event",
		# 	venue: Venue.new, category: Category.new)
  # 	render
  # 	expect(rendered).to include("<button class="btn btn-lg btn-block btn-danger"> BOOK NOW </button>")
  # end

  # it "should show alert when event is not published" do
  # 	event = Event.create!(name: "Michael Jackson", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a current event",
		# 	venue: Venue.new, category: Category.new)
  # 	render
  # 	expect(rendered).to include("<button class="btn btn-lg btn-block btn-danger"> BOOK NOW </button>")
  # end

  # it "should show alert when event is run out of tickets" do
  # 	event = Event.create!(name: "Michael Jackson", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a current event",
		# 	venue: Venue.new, category: Category.new)
  # 	render
  # 	expect(rendered).to include("<button class="btn btn-lg btn-block btn-danger"> BOOK NOW </button>")
  # end

  # it "should show alert when event is run out of ticket of a type" do
  # 	event = Event.create!(name: "Michael Jackson", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a current event",
		# 	venue: Venue.new, category: Category.new)
  # 	render
  # 	expect(rendered).to include("<button class="btn btn-lg btn-block btn-danger"> BOOK NOW </button>")
  # end

  it "should show title" do
  	render
  	expect(rendered).to include("<h3> ? </h3>", e.name)
  end

  it "should show time" do
  	render
  	expect(rendered).to include('<div class="time-details"> 
  		Saturday, 04 Mar 2017  1:00 PM 
  		</div>', e.ends_at.strftime('%A, %d %b %Y %l:%M %p'))
  end

  it "should show Venue" do
  	render
  	expect(rendered).to include('<div class="venue-details">
  		?
  		<br/>
  		?
  		</div>', e.venue.name, e.venue.full_address)
  end
end
