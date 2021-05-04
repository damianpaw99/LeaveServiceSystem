package edu.ib;

    public class IncorrectLoginPasswordException extends Exception {

        /**
         * Basic constructor
         *
         * @param message Message of error
         */
        public IncorrectLoginPasswordException(String message) {
            super(message);
        }

    }

