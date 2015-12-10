Paperclip::FaceCrop.detectors = {
  'OpenCV' =>  { 
    :face => %w(/usr/share/opencv/haarcascades/haarcascade_frontalface_alt_tree.xml
                /usr/share/opencv/haarcascades/haarcascade_frontalface_alt.xml
                /usr/share/opencv/haarcascades/haarcascade_profileface.xml),

    :parts => %w(/usr/share/opencv/haarcascades/haarcascade_mcs_nose.xml
                 /usr/share/opencv/haarcascades/haarcascade_mcs_lefteye.xml
                 /usr/share/opencv/haarcascades/haarcascade_mcs_righteye.xml)
  }
}