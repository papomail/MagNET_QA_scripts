#### Examples:
## 1
import numpy as np
import matplotlib.pyplot as plt
from plotly import offline as py
py.init_notebook_mode()
t = np.linspace(-20, 20, 500)
mypulse=np.sin(np.sin(t)/t)
plt.plot(t, mypulse)
plt.plot(t, np.sin(np.sin(t)/t))
py.iplot_mpl(plt.gcf())
mypulse(figsize=(0.2,0.2))


## 2
from plotly import offline
offline.init_notebook_mode()
offline.iplot([{"y": [1, 2, 1]}])

## 3
import matplotlib
matplotlib.use('Qt5Agg')
# This should be done before `import matplotlib.pyplot`
# 'Qt4Agg' for PyQt4 or PySide, 'Qt5Agg' for PyQt5
import matplotlib.pyplot as plt
import numpy as np
t = np.linspace(0, 20, 500)
plt.plot(t, np.sin(t))
plt.show()


## 4 JSON object
from IPython.display import JSON
data = {"foo": {"bar": "baz"}, "a": 1}
JSON(data)
