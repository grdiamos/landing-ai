
import tensorflow as tf

def main():
    model = load_model()

    print(model.summary())

    data = get_data()

    result = model.predict(data)

    print("result", result)

def load_model():
    return tf.keras.models.load_model('best_model')

def get_data():
    data = tf.zeros(
        (1, 512, 512, 3),
        dtype=tf.dtypes.float32
    )

    return data

main()

