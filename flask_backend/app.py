from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from marshmallow_sqlalchemy import ModelSchema
from marshmallow import fields
import config

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = config.mysql_uri
db = SQLAlchemy(app)


class Pet(db.Model):
    __tablename__ = "pets"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20))
    image_url = db.Column(db.String(200))
    times_pet = db.Column(db.Integer)

    def create(self):
        db.session.add(self)
        db.session.commit()
        return self

    def __init__(self, name, image_url, times_pet):
        self.name = name
        self.image_url = image_url
        self.times_pet = times_pet

    def __repr__(self):
        return '' % self.id


db.create_all()


class PetSchema(ModelSchema):

    class Meta(ModelSchema.Meta):
        model = Pet
        sqla_session = db.session

    id = fields.Integer(dump_only=True)
    name = fields.String(required=True)
    image_url = fields.String(required=True)
    times_pet = fields.Integer(required=True)


@app.route('/pets', methods=['GET'])
def get_pets():
    get_pets = Pet.query.all()
    pet_schema = PetSchema(many=True)
    pets = pet_schema.dump(get_pets)
    return make_response(
        jsonify(pets),
        200
    )


@app.route('/pets/<id>', methods=['GET'])
def get_pet_by_id(id):
    get_pet = Pet.query.get(id)
    if (get_pet):
        pet_schema = PetSchema()
        pet = pet_schema.dump(get_pet)
        return make_response(
            jsonify(pet),
            200
        )
    else:
        return make_response(
            "Not Found",
            404
        )


@app.route('/pets', methods=['POST'])
def create_pet():
    data = request.get_json()
    pet_schema = PetSchema()
    pet = pet_schema.load(data)
    result = pet_schema.dump(pet.create())
    return make_response(
        jsonify(result),
        201
    )


@app.route('/pets/<id>', methods=['PUT'])
def update_pet_by_id(id):
    data = request.get_json()
    get_pet = Pet.query.get(id)
    if (get_pet):
        if data.get('name'):
            get_pet.name = data['name']
        if data.get('image_url'):
            get_pet.image_url = data['image_url']
        if data.get('times_pet'):
            get_pet.times_pet = data['times_pet']
        db.session.add(get_pet)
        db.session.commit()
        pet_schema = PetSchema(
            only=[
                'id',
                'name',
                'image_url',
                'times_pet'
            ]
        )
        pet = pet_schema.dump(get_pet)
        return make_response(jsonify({pet}))
    else:
        return make_response(
            "Not Found",
            404
        )


@app.route('/pets/<id>', methods=['DELETE'])
def delete_pet_by_id(id):
    get_pet = Pet.query.get(id)
    if (get_pet):
        db.session.delete(get_pet)
        db.session.commit()
        return make_response(
            "",
            204
        )
    else:
        return make_response(
            "Not Found",
            404
        )


if __name__ == "__main__":
    app.run(debug=True)
