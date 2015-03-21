# Karaoke JS
A simple JavaScript-powered karaoke script. The script takes in a multi-dimensional array of lyrics
with specific timings for each word to be highlighted binded to a designated audio player element.

# Dependencies
The script uses the <a href="https://middlemanapp.com/">Middleman</a> framework.
The app uses the following:
<ul>
  <li><a href="http://slim-lang.com/">Slim</a> (HTML)</li>
  <li><a href="http://sass-lang.com/">Sass</a> (CSS)</li>
  <li><a href="http://coffeescript.org/">CoffeeScript</a> (JavaScript)</li>
  <li>jQuery 2.1.3</li>
</ul>

Although the script uses jQuery, the word-highlight animations are carried out with CSS3.

# Setup
To build off the app using the current framework, one would need to know how to use Middleman to do so.
It should be as easy as installing the framework using <code>gem install middleman</code> onto one's system and running <code>middleman server</code> or 
<code>middleman build</code>. More information can be found on the <a href="https://middlemanapp.com/">framework's website</a>.
<br />
<br />
Otherwise, it would be perfectly fine to just edit the files in the /build directory in this repository to do simple tasks
such as changing the audio player element to point to a specific track and adding the lyrics to the JavaScript. The only downside is that comments for the JavaScript are written in the CoffeeScript files. It might be helpful when reviewing example.js in the /build to check the example.js.coffee file in the /source folder for additional information.
<br />
<br />
To get karaoke demo going, one must set up the lyrics variable, set the settings variable (if desired), and then instantiate the Karaoke class. If no settings are supplied the script uses defaults.
<br />
<br />
The highlight styling can be changed in the karaoke.css file. 

# Credits
This application was built by <a href="http://www.codereloadrepeat.com/">Jake Larson</a> to be implemented in the <em>The
Changing Story</em> (to be released) eBook written by Linda Buturian, Susan Andre, and Thomas Nechodomu in the
<a href="http://cehd.umn.edu/">College of Education and Human Development</a> at the
<a href="http://www.umn.edu/">University of Minnesota — Twin Cities</a>.

# License
Karaoke JS is released under the <a href="http://www.opensource.org/licenses/MIT">MIT License</a>.
