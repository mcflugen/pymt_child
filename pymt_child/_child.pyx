# cython: c_string_type=str, c_string_encoding=ascii

import ctypes
from libc.stdlib cimport malloc, free

cimport numpy as np
import numpy as np

cimport _child




cdef class Child:
    cdef _child.Model _bmi
    cdef char[2048] STR_BUFFER

    def __cinit__(self):
        pass

    def buffer(self):
        return <bytes>self.STR_BUFFER

    def initialize(self, config_file):
        self._bmi.Initialize(config_file)

    def update(self):
        self._bmi.Update()

    def update_until(self, time):
        self._bmi.UpdateUntil(time)

    def finalize(self):
        self._bmi.Finalize()

    cpdef int get_var_grid(self, name):
        return self._bmi.GetVarGrid(<char*>name)

    cpdef object get_var_type(self, name):
        self._bmi.GetVarType(<char*>name, self.STR_BUFFER)
        return self.STR_BUFFER

    cpdef object get_var_units(self, name):
        self._bmi.GetVarUnits(<char*>name, self.STR_BUFFER)
        return self.STR_BUFFER

    cpdef int get_var_itemsize(self, name):
        return self._bmi.GetVarItemsize(<char*>name)

    cpdef int get_var_nbytes(self, name):
        return self._bmi.GetVarNbytes(<char*>name)

    cpdef object get_var_location(self, name):
        self._bmi.GetVarLocation(<char*>name, self.STR_BUFFER)
        return self.STR_BUFFER

    cpdef get_component_name(self):
        self._bmi.GetComponentName(self.STR_BUFFER)
        return self.STR_BUFFER

    cpdef int get_input_var_name_count(self):
        return self._bmi.GetInputVarNameCount()

    cpdef int get_output_var_name_count(self):
        return self._bmi.GetOutputVarNameCount()

    def get_input_var_names(self):
        cdef list py_names = []
        cdef char** names
        cdef int i
        cdef int count = self._bmi.GetInputVarNameCount()

        try:
            names = <char**>malloc(count * sizeof(char*))
            names[0] = <char*>malloc(count * 2048 * sizeof(char))
            for i in range(1, count):
                names[i] = names[i - 1] + 2048
            self._bmi.GetInputVarNames(names)

            for i in range(count):
                py_names.append(names[i])
        except Exception:
            raise
        finally:
            free(names[0])
            free(names)

        return tuple(py_names)

    def get_output_var_names(self):
        cdef list py_names = []
        cdef char** names
        cdef int i
        cdef int count = self._bmi.GetOutputVarNameCount()

        try:
            names = <char**>malloc(count * sizeof(char*))
            names[0] = <char*>malloc(count * 2048 * sizeof(char))
            for i in range(1, count):
                names[i] = names[i - 1] + 2048
            self._bmi.GetOutputVarNames(names)

            for i in range(count):
                py_names.append(names[i])
        except Exception:
            raise
        finally:
            free(names[0])
            free(names)

        return tuple(py_names)

    cpdef double get_current_time(self):
        return self._bmi.GetCurrentTime()

    cpdef double get_start_time(self):
        return self._bmi.GetStartTime()

    cpdef double get_end_time(self):
        return self._bmi.GetEndTime()

    cpdef object get_time_units(self):
        self._bmi.GetTimeUnits(self.STR_BUFFER)
        return self.STR_BUFFER

    cpdef double get_time_step(self):
        return self._bmi.GetTimeStep()

    cpdef get_value(self, name, np.ndarray buff):
        self._bmi.GetValue(<char*>name, buff.data)
        return buff

    cpdef set_value(self, name, np.ndarray buff):
        self._bmi.SetValue(<char*>name, buff.data)
        return buff

    cpdef int get_grid_rank(self, gid):
        return self._bmi.GetGridRank(gid)

    cpdef int get_grid_size(self, gid):
        return self._bmi.GetGridSize(gid)

    cpdef int get_grid_number_of_nodes(self, gid):
        return self._bmi.GetGridSize(gid)

    cpdef int get_grid_number_of_faces(self, gid):
        return self._bmi.GetGridNumberOfFaces(gid)

    # cpdef int get_grid_number_of_edges(self, gid):
    #     return self._bmi.GetGridNumberOfEdges(gid)

    cpdef object get_grid_type(self, gid):
        self._bmi.GetGridType(gid, self.STR_BUFFER)
        return self.STR_BUFFER

    cpdef get_grid_x(self, gid, np.ndarray[double, ndim=1] buff):
        self._bmi.GetGridX(gid, &buff[0])
        return buff

    cpdef get_grid_y(self, gid, np.ndarray[double, ndim=1] buff):
        self._bmi.GetGridY(gid, &buff[0])
        return buff

    cpdef get_grid_face_nodes(self, gid, np.ndarray[int, ndim=1] buff):
        self._bmi.GetGridFaceNodes(gid, &buff[0])
        return buff

    cpdef get_grid_nodes_per_face(self, gid, np.ndarray[int, ndim=1] buff):
        self._bmi.GetGridNodesPerFace(gid, &buff[0])
        return buff


