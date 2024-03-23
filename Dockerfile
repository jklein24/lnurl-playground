# Start from the latest golang base image
FROM golang:latest as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy everything from the current directory to the Working Directory inside the container
COPY . .

# Install dependencies
RUN go get -d -v ./...
RUN go install -v ./...

# Install npm
RUN apt-get update && apt-get install -y npm

# Install npm dependencies
RUN npm install

# Build the Go app
RUN make lnurl-playground

# Start a new stage from scratch
FROM alpine:latest  

RUN apk --no-cache add ca-certificates
RUN apk add --no-cache libc6-compat 

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/lnurl-playground .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./lnurl-playground"]
