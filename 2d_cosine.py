#! /usr/bin/python3

import numpy as np
import matplotlib.pyplot as pl
from matplotlib import cm
from matplotlib.widgets import Slider, Button, RadioButtons

fig, axis = pl.subplots()
pl.subplots_adjust(left=.1, bottom=.25)
x,y = np.meshgrid(
	np.linspace(-5,5,50),
	np.linspace(-5,5,50)
)
w_x0, w_y0, t_0 = 1.,1.,0.
cos_2d = np.cos(w_x0*x + w_y0*y + t_0)
c_level = np.arange(cos_2d.min(),cos_2d.max()+.01,.01)
contour = axis.contourf(x, y, cos_2d, c_level,cmap=cm.jet)
cbar = fig.colorbar(contour)
pl.axis([-5, 5, -5, 5])

axcolor = 'lightgoldenrodyellow'
ax_wx = pl.axes([0.1, 0.15, 0.75, 0.03], facecolor=axcolor)
ax_wy = pl.axes([0.1, 0.1, 0.75, 0.03], facecolor=axcolor)
ax_t = pl.axes([0.1, 0.05, 0.75, 0.03], facecolor=axcolor)

wx_sl = Slider(ax_wx, r'$\omega_x$', 0., 5., valinit=w_x0)
wy_sl = Slider(ax_wy, r'$\omega_y$', 0., 5., valinit=w_y0)
t_sl = Slider(ax_t, r'$\theta$', 0., np.pi*2, valinit=t_0)

def update(val):
	w_x = wx_sl.val
	w_y = wy_sl.val
	t = t_sl.val
	axis.contourf(x, y, np.cos(w_x*x+w_y*y + t), c_level, cmap=cm.jet)
	fig.canvas.draw_idle()

wx_sl.on_changed(update)
wy_sl.on_changed(update)
t_sl.on_changed(update)

pl.show()
