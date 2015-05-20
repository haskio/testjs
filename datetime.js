/**
 * Created by Administrator on 2015/5/14.
 */
now = new Date();
localtime = now.toString();
utctime = now.toGMTString();
document.write("<b>Local time:</b>" + localtime + "<br>");
document.write("<b>Utc time:" + utctime);

hous = now.getHours();
mins = now.getMinutes();
secs = now.getSeconds();

document.write("<h1>");
document.write(hous + ":" + mins + ":" + secs);
document.write("</h1>");