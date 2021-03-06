
#ifeq ($(TARGET_BOARD_PLATFORM),msm8960)

LOCAL_PATH:= $(call my-dir)
LOCAL_DIR_PATH:= $(call my-dir)
include $(CLEAR_VARS)

MM_CAM_FILES:= \
        mm_camera_interface2.c \
        mm_camera_stream.c \
        mm_camera_channel.c \
        mm_camera.c \
        mm_camera_poll_thread.c \
        mm_camera_notify.c \
        mm_camera_sock.c \
        mm_camera_helper.c \
        mm_omx_jpeg_encoder.c

LOCAL_CFLAGS+= -D_ANDROID_
LOCAL_COPY_HEADERS_TO := mm-camera-interface
LOCAL_COPY_HEADERS += mm_camera_interface2.h
LOCAL_COPY_HEADERS += mm_omx_jpeg_encoder.h

LOCAL_C_INCLUDES+= $(LOCAL_PATH)/..
LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
LOCAL_C_INCLUDES+= \
    $(TARGET_OUT_HEADERS)/mm-camera \
    $(TARGET_OUT_HEADERS)/mm-camera/common \
    $(TARGET_OUT_HEADERS)/mm-still \
    $(TARGET_OUT_HEADERS)/mm-still/jpeg \
    $(TARGET_OUT_HEADERS)/mm-still/mm-omx

LOCAL_C_INCLUDES+= hardware/qcom/media/mm-core/inc
ifneq ($(call is-platform-sdk-version-at-least,20),true)
LOCAL_CFLAGS += -include bionic/libc/kernel/arch-arm/asm/posix_types.h
LOCAL_CFLAGS += -include bionic/libc/kernel/arch-arm/asm/byteorder.h
LOCAL_CFLAGS += -include bionic/libc/kernel/common/linux/posix_types.h
LOCAL_CFLAGS += -include bionic/libc/kernel/common/linux/types.h
endif
LOCAL_CFLAGS += -include bionic/libc/include/sys/socket.h
LOCAL_CFLAGS += -include bionic/libc/include/netinet/in.h
LOCAL_CFLAGS += -include bionic/libc/include/sys/un.h

LOCAL_SRC_FILES := $(MM_CAM_FILES)

LOCAL_MODULE           := libmmcamera_interface2
LOCAL_PRELINK_MODULE   := false
LOCAL_SHARED_LIBRARIES := libdl libcutils liblog libmmstillomx libimage-jpeg-enc-omx-comp
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

#endif
