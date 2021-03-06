require File.dirname(__FILE__) + '/../../spec_helper'

describe "/posts/index.html" do
  before(:each) do
    allow(view).to receive(:enki_config).and_return(Enki::Config.default)

    mock_tag = mock_model(ActsAsTaggableOn::Tag,
      :name => 'code'
    )

    mock_post = mock_model(Post,
      :title             => "A post",
      :body_html         => "Posts contents!",
      :published_at      => 1.year.ago,
      :published?        => true,
      :slug              => 'a-post',
      :approved_comments => [mock_model(Comment)],
      :tags              => [mock_tag]
    )
    mock_posts = [mock_post, mock_post]
    allow(mock_posts).to receive(:total_pages).and_return(1)

    assign :posts, mock_posts
  end

  after(:each) do
    expect(rendered).to be_valid_html5_fragment
  end

  it "should render list of posts" do
    render :template => "/posts/index", :formats => [:html]
  end

  it "should render list of posts with a tag" do
    assigns[:tag] = 'code'
    render :template => "/posts/index", :formats => [:html]
  end
end
