var id = setInterval(frame, 15);
var left_inc = 1;
var right_inc = 1;
var tmp = 1;
var inc = 2;
var start = 1;

var base_max = 100;
var base_min = 10;
var base_current = 100;

var multiply = 2;
var direction = true;

	function frame() 
	{
		let canvas = document.getElementById('Triangle');  
		let ctx = canvas.getContext('2d');   
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		ctx.beginPath();
		  ctx.moveTo(300,50);
		  ctx.lineTo(250 + base_current,150 + left_inc);
		  ctx.lineTo(350 - base_current,150 + right_inc);
		  ctx.fillStyle = "yellow";
		  ctx.fill();
		ctx.beginPath();
		  ctx.moveTo(250,150);
		  ctx.lineTo(200 + base_current,250 + left_inc);
		  ctx.lineTo(300 - base_current,250 + right_inc);
		  ctx.fill();
		ctx.beginPath();
		  ctx.moveTo(350,150);
		  ctx.lineTo(300 + base_current,250 + left_inc);
		  ctx.lineTo(400 - base_current,250 + right_inc);
		  ctx.fill();

	if (direction) {
      if (base_current > base_min) {
        base_current -= 5 * multiply;
        left_inc -= inc * multiply;
        right_inc += inc * multiply;
      }
      else {
        tmp = left_inc;
        left_inc = right_inc;
        right_inc = tmp;
        direction = false;
      } 
    }
    else
    {
      if (base_current < base_max) {
        base_current += 5 * multiply;
        left_inc -= inc * multiply;
        right_inc += inc * multiply;
      }
      else {
        left_inc = start;
        right_inc = start;
        direction = true;
      }
    }
}

function SetMultiply(x) {
  multiply = x;
}