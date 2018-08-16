from __future__ import absolute_import

from pymt.framework.bmi_bridge import bmi_factory
from ._child import Child



Child = bmi_factory(Child)

del bmi_factory
