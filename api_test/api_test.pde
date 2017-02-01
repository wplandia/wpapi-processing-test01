float x_axis_alignment = 5;

public int countWord(String word) {
  if(word == null) {
    return 0;
  }
  String input = word.trim();
  int count = input.isEmpty() ? 0 : input.split("\\s+").length;
  return count;
}

void setup() {
  size(920,1300);
  //fullScreen();
  background(52,74,85);
  smooth(2);
  
  //Flip the y-axis so the lines go upwards (this flips everything though, including text)
  scale(1, -1);
  translate(0, -height);
  
  JSONArray json = loadJSONArray("https://make.wordpress.org/accessibility/wp-json/wp/v2/posts/?per_page=60");
  //println(json); //Prints entire json file
  
  for(int i = 0; i < json.size(); i++ ) {
  
    JSONObject post = json.getJSONObject(i);
    
    //Grabs type of each post
    String type = post.getString("type");
    
    //Grabs date of each post
    String date = post.getString("date");
    
    //Grabs title of each post
    JSONObject title = post.getJSONObject("title");
    String title_rendered = title.getString("rendered");
    
    //Grabs the content of each post
    JSONObject content = post.getJSONObject("content");
    String content_rendered = content.getString("rendered");
    
    //Print word count to console
    println(date + ", " + countWord(content_rendered) + ", " + title_rendered);
    
    float word_count = countWord(content_rendered);
    
    // Circles that show the number of posts on the x-axis
    fill(102,204,255);
    noStroke();
    ellipse(x_axis_alignment = x_axis_alignment + 15, 10, 5, 5);
    
    // Lines to show the word count of each post
    stroke(0,170,255);
    line(x_axis_alignment, 15, x_axis_alignment, word_count/2);
  }
  
}

void draw() {
  textSize(24);
  text("Word Counts per Post", 100,100);
}