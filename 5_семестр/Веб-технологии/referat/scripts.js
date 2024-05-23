mybutton = document.getElementById("scrollBtn");
myText = document.getElementById("top");

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
    myText.style.display = "block";
  } else {
    mybutton.style.display = "none";
    myText.style.display = "none";
  }
}


function topFunction() {
  document.body.scrollTop = 0; // For Safari
  document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
}

function toggleDarkMode() {
  var element = document.body;
  element.classList.toggle("dark-mode");
  var code = document.getElementsByTagName("code");
  for (var i=0; i<code.length; i++) {
    code[i].classList.toggle("dark-code");
  }
  var contentBtn = document.getElementsByClassName("content_button");
  for (var i=0; i<contentBtn.length; i++) {
    contentBtn[i].classList.toggle("dark-button");
  }
  var content = document.getElementsByClassName("dropdown-content");
  for (var i=0; i<content.length; i++) {
    content[i].classList.toggle("dark-drop");
  }
}