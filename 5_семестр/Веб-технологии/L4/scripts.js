let canvas
let context
let pixel_size = 30

function draw_back(){
  canvas = document.getElementById('grid')
  context = canvas.getContext('2d')

  context.translate(canvas.width/2,canvas.height/2)

  draw_axis()
}

function draw_axis(){
  context.lineWidth = 5

  context.beginPath();
  context.moveTo(-canvas.width/2, 0);
  context.lineTo(canvas.width/2, 0);
  context.stroke();

  context.beginPath();
  context.moveTo(0, -canvas.height/2);
  context.lineTo(0, canvas.height/2);
  context.stroke();
}


function draw_func(f){
  context.lineWidth = 2;
  context.beginPath();

  let x_tmp = -canvas.width/2
  let x = x_tmp/pixel_size
  let y = -eval(f) * pixel_size

  context.moveTo(x_tmp, y)

  while (x_tmp < canvas.width/2)
  {
    x_tmp += 1
    x = x_tmp / pixel_size
    y = - eval(f) * pixel_size
    context.lineTo(x_tmp, y)
  }

  context.stroke()
}


function draw(){
  let func = document.getElementById("func").value

  context.clearRect(-canvas.width/2,-canvas.height/2,canvas.width,canvas.height)
  draw_axis()
  draw_func(func)
}

