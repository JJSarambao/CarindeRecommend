import cv2
import numpy as np
import tensorflow as tf

# Load TFLite model
interpreter = tf.lite.Interpreter(model_path="model/lite-model_ssd_mobilenet_v1_1_metadata_2.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Open video capture device (webcam)
cap = cv2.VideoCapture(1)

# Set video capture resolution
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

output_data = interpreter.get_tensor(output_details[0]['index'])

while True:
    # Read frame from video capture device
    ret, frame = cap.read()

    # Preprocess input image
    input_data = cv2.resize(frame, (input_details[0]['shape'][1], input_details[0]['shape'][2]))
    input_data = input_data.astype('float32')
    input_data /= 255.0
    input_data = np.multiply(input_data, 255.0)
    input_data = input_data.astype('uint8')
    input_data = np.expand_dims(input_data, axis=0)

    # Run inference on the TFLite model
    interpreter.set_tensor(input_details[0]['index'], input_data)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])

    # Postprocess output
    boxes = output_data[0][:, 1:5]
    classes = output_data[0][:, 0]
    scores = output_data[0][:, 1]

    # Draw bounding boxes on the image
    for i in range(len(scores)):
        if ((scores[i] > 0.5) and (scores[i] <= 1.0)):
            # Get bounding box coordinates
            ymin = int(max(1,(boxes[i][0] * frame.shape[0])))
            xmin = int(max(1,(boxes[i][1] * frame.shape[1])))
            ymax = int(min(frame.shape[0],(boxes[i][2] * frame.shape[0])))
            xmax = int(min(frame.shape[1],(boxes[i][3] * frame.shape[1])))

            # Draw bounding box on the image
            cv2.rectangle(frame, (xmin,ymin), (xmax,ymax), (10, 255, 0), 2)

    # Display the resulting image
    cv2.imshow('Object detection', frame)

    # Exit if 'q' is pressed
    if cv2.waitKey(1) == ord('q'):
        break

# Release video capture device and close all windows
cap.release()
cv2.destroyAllWindows()
